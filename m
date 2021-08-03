Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132AE3DEFEA
	for <lists+linux-edac@lfdr.de>; Tue,  3 Aug 2021 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhHCORW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Aug 2021 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbhHCORT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Aug 2021 10:17:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC168C061757;
        Tue,  3 Aug 2021 07:17:08 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSsgkQyidqugKoRNTCZP5yDbH8jFazmpZt2/KUW+F/s=;
        b=Du4JS+BH/HTAUJZ9X5NLJmre8MxpiFP/Ky8LWI+7DJsTNnRtHowyOY3k+u//f7klolcEzJ
        H1f1allRSJNn7Y2Bzxdtkjy8ioxWmdhYKqJnfT1bpqav5nvYGCFUJniaVckcffZruPpP5V
        uH9xk5eRoPNBpvhh8fClS7mzvdorAvu6wDsUSRYbnSN/3PZbjLbnPbCUWPguu8E5SPJVcN
        jtWE9FqwMCvBIrYFYuo/5d7cMVKo4wf6EuLqEIh8KFSpsjxFdDEJ7XSjdCl6SaKFzMDF2d
        rlxmGrg7hQ09ySwpkJPQw5o++U0A9krvNw7v6nI6u1TtU6Knqo0HQv8HH1OTKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSsgkQyidqugKoRNTCZP5yDbH8jFazmpZt2/KUW+F/s=;
        b=TGFVzas8ZsvkHvnkzz1TPwkqatK6j3kL5fnP32YZBs7HleTJS8N0vMc2HMFhWDedNsYQPZ
        6P/3UrscLGsb+QAQ==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH 09/38] x86/mce/inject: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:52 +0200
Message-Id: <20210803141621.780504-10-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/mce/inject.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inj=
ect.c
index 4e86d97f96530..0bfc14041bbb4 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -235,7 +235,7 @@ static void __maybe_unused raise_mce(struct mce *m)
 		unsigned long start;
 		int cpu;
=20
-		get_online_cpus();
+		cpus_read_lock();
 		cpumask_copy(mce_inject_cpumask, cpu_online_mask);
 		cpumask_clear_cpu(get_cpu(), mce_inject_cpumask);
 		for_each_online_cpu(cpu) {
@@ -269,7 +269,7 @@ static void __maybe_unused raise_mce(struct mce *m)
 		}
 		raise_local();
 		put_cpu();
-		put_online_cpus();
+		cpus_read_unlock();
 	} else {
 		preempt_disable();
 		raise_local();
@@ -529,7 +529,7 @@ static void do_inject(void)
 		cpu =3D get_nbc_for_node(topology_die_id(cpu));
 	}
=20
-	get_online_cpus();
+	cpus_read_lock();
 	if (!cpu_online(cpu))
 		goto err;
=20
@@ -553,7 +553,7 @@ static void do_inject(void)
 	}
=20
 err:
-	put_online_cpus();
+	cpus_read_unlock();
=20
 }
=20
--=20
2.32.0

