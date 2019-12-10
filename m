Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05224119242
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 21:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLJUkK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Dec 2019 15:40:10 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUkK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Dec 2019 15:40:10 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8yoa-1ic30Q0886-0067ql; Tue, 10 Dec 2019 21:39:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        bberg@redhat.com, ckellner@redhat.com, hdegoede@redhat.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce/therm_throt: mark throttle_active_work as __maybe_unused
Date:   Tue, 10 Dec 2019 21:39:13 +0100
Message-Id: <20191210203925.3119091-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VvX2CPJbY4hvt8Tzl0Tk/uqCvbS1Yvswk4+Cz85uUFkxV5T1BHM
 ptYXLp9GzAL5B48jbB/OZQjmM4pF6tydVOA/8xT0ZDukdRzHPPhAhE/8G49HHJwjKRpYKMX
 tCfYneTIisbuZvIb/yLZTH7K0ULi4y0bmuVdO0aA+lGlzewu9wjKwOAcVZY8KnaDNhYLp/L
 GybRisYFrTyuTLMvySKug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:clbJ3G5bkOQ=:Y0JgssQH5r4ZQOMKi778tQ
 m52mWP0VeKwN9oYY70RFsdcwX31HGcnBhTceSZwb48HFslraXHiGNPyfluReVKgEDM4iyZSTR
 tUGR3CIL80Ydb/CqDqNQkPq4UuN55oaNDWculfJzM2oOgeCh82xE1VM/9mrfSA0SJDW5rNGM5
 0o0ZhTBVkc4Bt+m9EH9e5lhuJFfCpBZhRgwbOJBWbzLSp/+zVyPrD3Bec1tM1cvTIL/UTi5Hk
 Oe4FuRXtXbZMc3LsqlWIbE6kgx11/ycgJYzeighOGW21mTeBulm/brSqWuOuo/ExVHO/pY9xh
 GBnxzRk/7kYPlpLrJArHdt1QMqW8DkvgVqNebN7IqfTHJlxC1ij5RoZwF+xAAw0KwErhjT9Px
 OWsd8t2o+BXRjDmHLxcwqTkhD+RloVnKz4ojnIZpuHHl9h4lGOyuVVcFeDRcV/Q5NwBsQcHT9
 zPHjk6+hYdS7sezquiAFNVB1hfLX2k2C9vBUJ3m9b02IjTiXlcqeuVukXQElCMJtg6vNxlLlx
 LZJTKsPeStIwZd8fdhGZxCGxGZaLiRGWVFnhP2s20c97kwQXa8M/rGQ0eB5rjpDhqpUshBdk2
 CNHOJeu/KstDmVGtHBsCmDI4rVB0R1UXKqzRQT712Qzw/SiKXl0blYDpmHTBE3+oUJ5YMbLEF
 unSnu2UFkX4AGd8wwyJ3KZK1RvZ7amjf3D6PCi0M7GbdycETTMu4QfsC/gAO97qL5y251h79h
 B0WXEehB5uU3E5liM48pG83g2ixzPuQ3y7BDnExNJ17dANOC+ZMOLF+G+RDoyoGjK0oSkctcs
 qo8n3rktf+O7S9fm0wWT5qSJa8ljCZxj/qQoTVYAa8LKH22twZwMwyVS/50EkMJIYsQvAkxVE
 INDcHpuv/j+xlFhTXH5A==
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

throttle_active_work() is only called if CONFIG_SYSFS is set,
otherwise we get a harmless warning:

arch/x86/kernel/cpu/mce/therm_throt.c:238:13: error: 'throttle_active_work' defined but not used [-Werror=unused-function]

Mark the function as __maybe_unused to avoid the warning.

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index b38010b541d6..8963493a1e9e 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -235,7 +235,7 @@ static void get_therm_status(int level, bool *proc_hot, u8 *temp)
 	*temp = (msr_val >> 16) & 0x7F;
 }
 
-static void throttle_active_work(struct work_struct *work)
+static void __maybe_unused throttle_active_work(struct work_struct *work)
 {
 	struct _thermal_state *state = container_of(to_delayed_work(work),
 						struct _thermal_state, therm_work);
-- 
2.20.0

