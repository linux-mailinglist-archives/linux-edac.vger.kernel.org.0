Return-Path: <linux-edac+bounces-1509-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B892FB00
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8B3B22742
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3E171068;
	Fri, 12 Jul 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eapYYC1Y"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F599170829;
	Fri, 12 Jul 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790122; cv=none; b=Zx8O92OwwlHUlhXjAY5H1H1yv5T5fnFPF0D1mkN7oPC9iyixLiLQSN9mRD5K0t5yDkoXAk9mQXZQjk2PS0frY+MzGOMEQNUkqE38jjtC5H/dGsjsLrxoxip6LbsSNDblUFb6xMFndxpBoNNe6j4LLjH7VseS6vrBASCOgNlcKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790122; c=relaxed/simple;
	bh=9YH+uN2FpTDfQsql9e3P4xbbtz8E4TbY1G0zlNhC2vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oh8hoTxFsqA1zW851iyW2QGWk9uxzOcbZj52zJUtopWhhybxFXNVmKJGolucgIdcvffroL2QgO2UydTkeEs9fXIQiknh0J6czkegtYLnWkGtqLRxZSx30QhPHh+TdWWGPKO8XXK9xMxP4Nxs7ksw+W6jEzooKpxKL0Vw3TXTovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eapYYC1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CAEC4AF10;
	Fri, 12 Jul 2024 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720790122;
	bh=9YH+uN2FpTDfQsql9e3P4xbbtz8E4TbY1G0zlNhC2vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eapYYC1YsFxVkG74Ij9c7WPxBrDik6Dqz5rJDE067AbX4V7pyvKO6RY/TBroOU5cb
	 i9NYFBukMQs8CJKDCGCMSpuGTmIf7zD1x4HHEBoPVzh0viqR3CR3jRddADhVMzc7JS
	 nwlpJuMzv4wokjqYHdC82c7TxO8JXL1HVST+t1toy0fvyEJvMR09s9E5G/pSfkDgAH
	 hLpFOKLu4dIMADQInwO6h5sLrv6HK2ganuIdozDycsvr2CWfOg+J3AyJ9Fc20wMXEA
	 KsBQmLZYMeB8i/t4aqRJhEosxKpNjU1Lb/E+7mNwsrgAVjqpERP0203NQMYHluXqQ3
	 mPWoOMxPRO5jg==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sSG7K-00000003iED-1V73;
	Fri, 12 Jul 2024 15:15:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Shiju Jose" <shiju.jose@huawei.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] target/arm: preserve mpidr value
Date: Fri, 12 Jul 2024 15:15:12 +0200
Message-ID: <f0b1356f3f734446ed490911871510965d5cbd2c.1720789922.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720789921.git.mchehab+huawei@kernel.org>
References: <cover.1720789921.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

There is a logic at helper to properly fill the mpidr information.
This is needed for ARM Processor error injection, so store the
value inside a cpu opaque value, to allow it to be used.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a12859fc5335..d2e86f0877cc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1033,6 +1033,7 @@ struct ArchCPU {
         uint64_t reset_pmcr_el0;
     } isar;
     uint64_t midr;
+    uint64_t mpidr;
     uint32_t revidr;
     uint32_t reset_fpsid;
     uint64_t ctr;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ce319572354a..2432b5b09607 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4692,7 +4692,7 @@ static uint64_t mpidr_read_val(CPUARMState *env)
     return mpidr;
 }
 
-static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+static uint64_t mpidr_read(CPUARMState *env)
 {
     unsigned int cur_el = arm_current_el(env);
 
@@ -4702,6 +4702,11 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return mpidr_read_val(env);
 }
 
+static uint64_t mpidr_read_ri(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return mpidr_read(env);
+}
+
 static const ARMCPRegInfo lpae_cp_reginfo[] = {
     /* NOP AMAIR0/1 */
     { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
@@ -9723,7 +9728,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "MPIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
               .fgt = FGT_MPIDR_EL1,
-              .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
+              .access = PL1_R, .readfn = mpidr_read_ri, .type = ARM_CP_NO_RAW },
         };
 #ifdef CONFIG_USER_ONLY
         static const ARMCPRegUserSpaceInfo mpidr_user_cp_reginfo[] = {
@@ -9733,6 +9738,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         modify_arm_cp_regs(mpidr_cp_reginfo, mpidr_user_cp_reginfo);
 #endif
         define_arm_cp_regs(cpu, mpidr_cp_reginfo);
+        cpu->mpidr = mpidr_read(env);
     }
 
     if (arm_feature(env, ARM_FEATURE_AUXCR)) {
-- 
2.45.2


