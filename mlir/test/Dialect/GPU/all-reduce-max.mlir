// RUN: mlir-opt -test-gpu-rewrite %s | FileCheck %s

// NOTE: Assertions have been autogenerated by utils/generate-test-checks.py
// CHECK: gpu.module @kernels {
gpu.module @kernels {

  // CHECK-LABEL: gpu.func @kernel(
  // CHECK-SAME: [[VAL_0:%.*]]: f32) workgroup([[VAL_1:%.*]] : memref<32xf32, 3>) kernel {
  gpu.func @kernel(%arg0 : f32) kernel {
    // CHECK-DAG:   [[VAL_2:%.*]] = arith.constant 31 : i32
    // CHECK-DAG:   [[VAL_3:%.*]] = arith.constant 0 : i32
    // CHECK-DAG:   [[VAL_4:%.*]] = arith.constant 0 : index
    // CHECK-DAG:   [[VAL_5:%.*]] = arith.constant 32 : i32
    // CHECK-DAG:   [[VAL_6:%.*]] = arith.constant 1 : i32
    // CHECK-DAG:   [[VAL_7:%.*]] = arith.constant 2 : i32
    // CHECK-DAG:   [[VAL_8:%.*]] = arith.constant 4 : i32
    // CHECK-DAG:   [[VAL_9:%.*]] = arith.constant 8 : i32
    // CHECK-DAG:   [[VAL_10:%.*]] = arith.constant 16 : i32
    // CHECK:   [[VAL_11:%.*]] = gpu.block_dim x
    // CHECK:   [[VAL_12:%.*]] = arith.index_cast [[VAL_11]] : index to i32
    // CHECK:   [[VAL_13:%.*]] = gpu.block_dim y
    // CHECK:   [[VAL_14:%.*]] = arith.index_cast [[VAL_13]] : index to i32
    // CHECK:   [[VAL_15:%.*]] = gpu.block_dim z
    // CHECK:   [[VAL_16:%.*]] = arith.index_cast [[VAL_15]] : index to i32
    // CHECK:   [[VAL_17:%.*]] = gpu.thread_id x
    // CHECK:   [[VAL_18:%.*]] = arith.index_cast [[VAL_17]] : index to i32
    // CHECK:   [[VAL_19:%.*]] = gpu.thread_id y
    // CHECK:   [[VAL_20:%.*]] = arith.index_cast [[VAL_19]] : index to i32
    // CHECK:   [[VAL_21:%.*]] = gpu.thread_id z
    // CHECK:   [[VAL_22:%.*]] = arith.index_cast [[VAL_21]] : index to i32
    // CHECK:   [[VAL_23:%.*]] = arith.muli [[VAL_22]], [[VAL_14]] : i32
    // CHECK:   [[VAL_24:%.*]] = arith.addi [[VAL_23]], [[VAL_20]] : i32
    // CHECK:   [[VAL_25:%.*]] = arith.muli [[VAL_24]], [[VAL_12]] : i32
    // CHECK:   [[VAL_26:%.*]] = arith.muli [[VAL_12]], [[VAL_14]] : i32
    // CHECK:   [[VAL_27:%.*]] = arith.addi [[VAL_25]], [[VAL_18]] : i32
    // CHECK:   [[VAL_28:%.*]] = arith.muli [[VAL_26]], [[VAL_16]] : i32
    // CHECK:   [[VAL_29:%.*]] = arith.andi [[VAL_27]], [[VAL_2]] : i32
    // CHECK:   [[VAL_30:%.*]] = arith.cmpi eq, [[VAL_29]], [[VAL_3]] : i32
    // CHECK:   [[VAL_31:%.*]] = arith.subi [[VAL_27]], [[VAL_29]] : i32
    // CHECK:   [[VAL_32:%.*]] = arith.subi [[VAL_28]], [[VAL_31]] : i32
    // CHECK:   [[VAL_33:%.*]] = arith.cmpi slt, [[VAL_32]], [[VAL_5]] : i32
    // CHECK:   cf.cond_br [[VAL_33]], ^bb1, ^bb17
    // CHECK: ^bb1:
    // CHECK:   [[VAL_34:%.*]], [[VAL_35:%.*]] = gpu.shuffle xor [[VAL_0]], [[VAL_6]], [[VAL_32]] : f32
    // CHECK:   cf.cond_br [[VAL_35]], ^bb2, ^bb3
    // CHECK: ^bb2:
    // CHECK:   [[VAL_36:%.*]] = arith.cmpf ugt, [[VAL_0]], [[VAL_34]] : f32
    // CHECK:   [[VAL_37:%.*]] = arith.select [[VAL_36]], [[VAL_0]], [[VAL_34]] : f32
    // CHECK:   cf.br ^bb4([[VAL_37]] : f32)
    // CHECK: ^bb3:
    // CHECK:   cf.br ^bb4([[VAL_0]] : f32)
    // CHECK: ^bb4([[VAL_38:%.*]]: f32):
    // CHECK:   [[VAL_39:%.*]], [[VAL_40:%.*]] = gpu.shuffle xor [[VAL_38]], [[VAL_7]], [[VAL_32]] : f32
    // CHECK:   cf.cond_br [[VAL_40]], ^bb5, ^bb6
    // CHECK: ^bb5:
    // CHECK:   [[VAL_41:%.*]] = arith.cmpf ugt, [[VAL_38]], [[VAL_39]] : f32
    // CHECK:   [[VAL_42:%.*]] = arith.select [[VAL_41]], [[VAL_38]], [[VAL_39]] : f32
    // CHECK:   cf.br ^bb7([[VAL_42]] : f32)
    // CHECK: ^bb6:
    // CHECK:   cf.br ^bb7([[VAL_38]] : f32)
    // CHECK: ^bb7([[VAL_43:%.*]]: f32):
    // CHECK:   [[VAL_44:%.*]], [[VAL_45:%.*]] = gpu.shuffle xor [[VAL_43]], [[VAL_8]], [[VAL_32]] : f32
    // CHECK:   cf.cond_br [[VAL_45]], ^bb8, ^bb9
    // CHECK: ^bb8:
    // CHECK:   [[VAL_46:%.*]] = arith.cmpf ugt, [[VAL_43]], [[VAL_44]] : f32
    // CHECK:   [[VAL_47:%.*]] = arith.select [[VAL_46]], [[VAL_43]], [[VAL_44]] : f32
    // CHECK:   cf.br ^bb10([[VAL_47]] : f32)
    // CHECK: ^bb9:
    // CHECK:   cf.br ^bb10([[VAL_43]] : f32)
    // CHECK: ^bb10([[VAL_48:%.*]]: f32):
    // CHECK:   [[VAL_49:%.*]], [[VAL_50:%.*]] = gpu.shuffle xor [[VAL_48]], [[VAL_9]], [[VAL_32]] : f32
    // CHECK:   cf.cond_br [[VAL_50]], ^bb11, ^bb12
    // CHECK: ^bb11:
    // CHECK:   [[VAL_51:%.*]] = arith.cmpf ugt, [[VAL_48]], [[VAL_49]] : f32
    // CHECK:   [[VAL_52:%.*]] = arith.select [[VAL_51]], [[VAL_48]], [[VAL_49]] : f32
    // CHECK:   cf.br ^bb13([[VAL_52]] : f32)
    // CHECK: ^bb12:
    // CHECK:   cf.br ^bb13([[VAL_48]] : f32)
    // CHECK: ^bb13([[VAL_53:%.*]]: f32):
    // CHECK:   [[VAL_54:%.*]], [[VAL_55:%.*]] = gpu.shuffle xor [[VAL_53]], [[VAL_10]], [[VAL_32]] : f32
    // CHECK:   cf.cond_br [[VAL_55]], ^bb14, ^bb15
    // CHECK: ^bb14:
    // CHECK:   [[VAL_56:%.*]] = arith.cmpf ugt, [[VAL_53]], [[VAL_54]] : f32
    // CHECK:   [[VAL_57:%.*]] = arith.select [[VAL_56]], [[VAL_53]], [[VAL_54]] : f32
    // CHECK:   cf.br ^bb16([[VAL_57]] : f32)
    // CHECK: ^bb15:
    // CHECK:   cf.br ^bb16([[VAL_53]] : f32)
    // CHECK: ^bb16([[VAL_58:%.*]]: f32):
    // CHECK:   cf.br ^bb18([[VAL_58]] : f32)
    // CHECK: ^bb17:
    // CHECK:   [[VAL_59:%.*]], [[VAL_60:%.*]] = gpu.shuffle xor [[VAL_0]], [[VAL_6]], [[VAL_5]] : f32
    // CHECK:   [[VAL_61:%.*]] = arith.cmpf ugt, [[VAL_0]], [[VAL_59]] : f32
    // CHECK:   [[VAL_62:%.*]] = arith.select [[VAL_61]], [[VAL_0]], [[VAL_59]] : f32
    // CHECK:   [[VAL_63:%.*]], [[VAL_64:%.*]] = gpu.shuffle xor [[VAL_62]], [[VAL_7]], [[VAL_5]] : f32
    // CHECK:   [[VAL_65:%.*]] = arith.cmpf ugt, [[VAL_62]], [[VAL_63]] : f32
    // CHECK:   [[VAL_66:%.*]] = arith.select [[VAL_65]], [[VAL_62]], [[VAL_63]] : f32
    // CHECK:   [[VAL_67:%.*]], [[VAL_68:%.*]] = gpu.shuffle xor [[VAL_66]], [[VAL_8]], [[VAL_5]] : f32
    // CHECK:   [[VAL_69:%.*]] = arith.cmpf ugt, [[VAL_66]], [[VAL_67]] : f32
    // CHECK:   [[VAL_70:%.*]] = arith.select [[VAL_69]], [[VAL_66]], [[VAL_67]] : f32
    // CHECK:   [[VAL_71:%.*]], [[VAL_72:%.*]] = gpu.shuffle xor [[VAL_70]], [[VAL_9]], [[VAL_5]] : f32
    // CHECK:   [[VAL_73:%.*]] = arith.cmpf ugt, [[VAL_70]], [[VAL_71]] : f32
    // CHECK:   [[VAL_74:%.*]] = arith.select [[VAL_73]], [[VAL_70]], [[VAL_71]] : f32
    // CHECK:   [[VAL_75:%.*]], [[VAL_76:%.*]] = gpu.shuffle xor [[VAL_74]], [[VAL_10]], [[VAL_5]] : f32
    // CHECK:   [[VAL_77:%.*]] = arith.cmpf ugt, [[VAL_74]], [[VAL_75]] : f32
    // CHECK:   [[VAL_78:%.*]] = arith.select [[VAL_77]], [[VAL_74]], [[VAL_75]] : f32
    // CHECK:   cf.br ^bb18([[VAL_78]] : f32)
    // CHECK: ^bb18([[VAL_79:%.*]]: f32):
    // CHECK:   cf.cond_br [[VAL_30]], ^bb19, ^bb20
    // CHECK: ^bb19:
    // CHECK:   [[VAL_80:%.*]] = arith.divsi [[VAL_27]], [[VAL_5]] : i32
    // CHECK:   [[VAL_81:%.*]] = arith.index_cast [[VAL_80]] : i32 to index
    // CHECK:   store [[VAL_79]], [[VAL_1]]{{\[}}[[VAL_81]]] : memref<32xf32, 3>
    // CHECK:   cf.br ^bb21
    // CHECK: ^bb20:
    // CHECK:   cf.br ^bb21
    // CHECK: ^bb21:
    // CHECK:   gpu.barrier
    // CHECK:   [[VAL_82:%.*]] = arith.addi [[VAL_28]], [[VAL_2]] : i32
    // CHECK:   [[VAL_83:%.*]] = arith.divsi [[VAL_82]], [[VAL_5]] : i32
    // CHECK:   [[VAL_84:%.*]] = arith.cmpi slt, [[VAL_27]], [[VAL_83]] : i32
    // CHECK:   cf.cond_br [[VAL_84]], ^bb22, ^bb41
    // CHECK: ^bb22:
    // CHECK:   [[VAL_85:%.*]] = arith.index_cast [[VAL_27]] : i32 to index
    // CHECK:   [[VAL_86:%.*]] = memref.load [[VAL_1]]{{\[}}[[VAL_85]]] : memref<32xf32, 3>
    // CHECK:   [[VAL_87:%.*]] = arith.cmpi slt, [[VAL_83]], [[VAL_5]] : i32
    // CHECK:   cf.cond_br [[VAL_87]], ^bb23, ^bb39
    // CHECK: ^bb23:
    // CHECK:   [[VAL_88:%.*]], [[VAL_89:%.*]] = gpu.shuffle xor [[VAL_86]], [[VAL_6]], [[VAL_83]] : f32
    // CHECK:   cf.cond_br [[VAL_89]], ^bb24, ^bb25
    // CHECK: ^bb24:
    // CHECK:   [[VAL_90:%.*]] = arith.cmpf ugt, [[VAL_86]], [[VAL_88]] : f32
    // CHECK:   [[VAL_91:%.*]] = arith.select [[VAL_90]], [[VAL_86]], [[VAL_88]] : f32
    // CHECK:   cf.br ^bb26([[VAL_91]] : f32)
    // CHECK: ^bb25:
    // CHECK:   cf.br ^bb26([[VAL_86]] : f32)
    // CHECK: ^bb26([[VAL_92:%.*]]: f32):
    // CHECK:   [[VAL_93:%.*]], [[VAL_94:%.*]] = gpu.shuffle xor [[VAL_92]], [[VAL_7]], [[VAL_83]] : f32
    // CHECK:   cf.cond_br [[VAL_94]], ^bb27, ^bb28
    // CHECK: ^bb27:
    // CHECK:   [[VAL_95:%.*]] = arith.cmpf ugt, [[VAL_92]], [[VAL_93]] : f32
    // CHECK:   [[VAL_96:%.*]] = arith.select [[VAL_95]], [[VAL_92]], [[VAL_93]] : f32
    // CHECK:   cf.br ^bb29([[VAL_96]] : f32)
    // CHECK: ^bb28:
    // CHECK:   cf.br ^bb29([[VAL_92]] : f32)
    // CHECK: ^bb29([[VAL_97:%.*]]: f32):
    // CHECK:   [[VAL_98:%.*]], [[VAL_99:%.*]] = gpu.shuffle xor [[VAL_97]], [[VAL_8]], [[VAL_83]] : f32
    // CHECK:   cf.cond_br [[VAL_99]], ^bb30, ^bb31
    // CHECK: ^bb30:
    // CHECK:   [[VAL_100:%.*]] = arith.cmpf ugt, [[VAL_97]], [[VAL_98]] : f32
    // CHECK:   [[VAL_101:%.*]] = arith.select [[VAL_100]], [[VAL_97]], [[VAL_98]] : f32
    // CHECK:   cf.br ^bb32([[VAL_101]] : f32)
    // CHECK: ^bb31:
    // CHECK:   cf.br ^bb32([[VAL_97]] : f32)
    // CHECK: ^bb32([[VAL_102:%.*]]: f32):
    // CHECK:   [[VAL_103:%.*]], [[VAL_104:%.*]] = gpu.shuffle xor [[VAL_102]], [[VAL_9]], [[VAL_83]] : f32
    // CHECK:   cf.cond_br [[VAL_104]], ^bb33, ^bb34
    // CHECK: ^bb33:
    // CHECK:   [[VAL_105:%.*]] = arith.cmpf ugt, [[VAL_102]], [[VAL_103]] : f32
    // CHECK:   [[VAL_106:%.*]] = arith.select [[VAL_105]], [[VAL_102]], [[VAL_103]] : f32
    // CHECK:   cf.br ^bb35([[VAL_106]] : f32)
    // CHECK: ^bb34:
    // CHECK:   cf.br ^bb35([[VAL_102]] : f32)
    // CHECK: ^bb35([[VAL_107:%.*]]: f32):
    // CHECK:   [[VAL_108:%.*]], [[VAL_109:%.*]] = gpu.shuffle xor [[VAL_107]], [[VAL_10]], [[VAL_83]] : f32
    // CHECK:   cf.cond_br [[VAL_109]], ^bb36, ^bb37
    // CHECK: ^bb36:
    // CHECK:   [[VAL_110:%.*]] = arith.cmpf ugt, [[VAL_107]], [[VAL_108]] : f32
    // CHECK:   [[VAL_111:%.*]] = arith.select [[VAL_110]], [[VAL_107]], [[VAL_108]] : f32
    // CHECK:   cf.br ^bb38([[VAL_111]] : f32)
    // CHECK: ^bb37:
    // CHECK:   cf.br ^bb38([[VAL_107]] : f32)
    // CHECK: ^bb38([[VAL_112:%.*]]: f32):
    // CHECK:   cf.br ^bb40([[VAL_112]] : f32)
    // CHECK: ^bb39:
    // CHECK:   [[VAL_113:%.*]], [[VAL_114:%.*]] = gpu.shuffle xor [[VAL_86]], [[VAL_6]], [[VAL_5]] : f32
    // CHECK:   [[VAL_115:%.*]] = arith.cmpf ugt, [[VAL_86]], [[VAL_113]] : f32
    // CHECK:   [[VAL_116:%.*]] = arith.select [[VAL_115]], [[VAL_86]], [[VAL_113]] : f32
    // CHECK:   [[VAL_117:%.*]], [[VAL_118:%.*]] = gpu.shuffle xor [[VAL_116]], [[VAL_7]], [[VAL_5]] : f32
    // CHECK:   [[VAL_119:%.*]] = arith.cmpf ugt, [[VAL_116]], [[VAL_117]] : f32
    // CHECK:   [[VAL_120:%.*]] = arith.select [[VAL_119]], [[VAL_116]], [[VAL_117]] : f32
    // CHECK:   [[VAL_121:%.*]], [[VAL_122:%.*]] = gpu.shuffle xor [[VAL_120]], [[VAL_8]], [[VAL_5]] : f32
    // CHECK:   [[VAL_123:%.*]] = arith.cmpf ugt, [[VAL_120]], [[VAL_121]] : f32
    // CHECK:   [[VAL_124:%.*]] = arith.select [[VAL_123]], [[VAL_120]], [[VAL_121]] : f32
    // CHECK:   [[VAL_125:%.*]], [[VAL_126:%.*]] = gpu.shuffle xor [[VAL_124]], [[VAL_9]], [[VAL_5]] : f32
    // CHECK:   [[VAL_127:%.*]] = arith.cmpf ugt, [[VAL_124]], [[VAL_125]] : f32
    // CHECK:   [[VAL_128:%.*]] = arith.select [[VAL_127]], [[VAL_124]], [[VAL_125]] : f32
    // CHECK:   [[VAL_129:%.*]], [[VAL_130:%.*]] = gpu.shuffle xor [[VAL_128]], [[VAL_10]], [[VAL_5]] : f32
    // CHECK:   [[VAL_131:%.*]] = arith.cmpf ugt, [[VAL_128]], [[VAL_129]] : f32
    // CHECK:   [[VAL_132:%.*]] = arith.select [[VAL_131]], [[VAL_128]], [[VAL_129]] : f32
    // CHECK:   cf.br ^bb40([[VAL_132]] : f32)
    // CHECK: ^bb40([[VAL_133:%.*]]: f32):
    // CHECK:   store [[VAL_133]], [[VAL_1]]{{\[}}[[VAL_4]]] : memref<32xf32, 3>
    // CHECK:   cf.br ^bb42
    // CHECK: ^bb41:
    // CHECK:   cf.br ^bb42
    // CHECK: ^bb42:
    // CHECK:   gpu.barrier
    %sum = gpu.all_reduce max %arg0 uniform {} : (f32) -> (f32)
    gpu.return
  }

}