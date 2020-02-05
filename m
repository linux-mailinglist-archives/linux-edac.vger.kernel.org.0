Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F314153156
	for <lists+linux-edac@lfdr.de>; Wed,  5 Feb 2020 13:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBEM6n (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Feb 2020 07:58:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726386AbgBEM6l (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Feb 2020 07:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580907520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EsKI13uEInV1+e+5h+hQckTbAfRjcgKQBLxQjiFbWOU=;
        b=Mfz+4QrWmKR4w7tUiqf6HBe/IdRK3NHnzGxS22huJJ43p4A9hjJLg3a3sfsQBlJIYxjycv
        Hg0bcjaq3TWUvh7/L+Ci0Sow1iOldFuDaRz9jvFGVH1b932x3Nk9tr9+LHRGIv4oGo9qEi
        rCJSzPbap9e0hwAqmPipNv4wxGmqL7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Jl4Bo-I3NZyj9UCfKmcPvQ-1; Wed, 05 Feb 2020 07:58:36 -0500
X-MC-Unique: Jl4Bo-I3NZyj9UCfKmcPvQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 900698010EF;
        Wed,  5 Feb 2020 12:58:34 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02FCB5DA7D;
        Wed,  5 Feb 2020 12:58:32 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142
Date:   Wed,  5 Feb 2020 07:58:31 -0500
Message-Id: <20200205125831.20430-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Intel Errata HSD131, HSM142, HSW131, and BDM48 report that
"spurious corrected errors may be logged in the IA32_MC0_STATUS register
with the valid field (bit 63) set, the uncorrected error field (bit 61)
not set, a Model Specific Error Code (bits [31:16]) of 0x000F, and
an MCA Error Code (bits [15:0]) of 0x0005."

Block these spurious errors from the console and logs.

Links to Intel Specification updates:
HSD131: https://www.intel.com/content/www/us/en/products/docs/processors/=
core/4th-gen-core-family-desktop-specification-update.html
HSM142: https://www.intel.com/content/www/us/en/products/docs/processors/=
core/4th-gen-core-family-mobile-specification-update.html
HSW131: https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1=
200v3-spec-update.html
BDM48: https://www.intel.com/content/www/us/en/products/docs/processors/c=
ore/5th-gen-core-family-spec-update.html

Signed-off-by: Alexander Krupp <centos@akr.yagii.de>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-edac@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
index 2c4f949611e4..d893cc764a06 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -121,6 +121,8 @@ static struct irq_work mce_irq_work;
=20
 static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs =
*regs);
=20
+static int (*quirk_noprint)(struct mce *m);
+
 /*
  * CPU/chipset specific EDAC code can register a notifier call here to p=
rint
  * MCE errors in a human-readable form.
@@ -232,6 +234,9 @@ struct mca_msr_regs msr_ops =3D {
=20
 static void __print_mce(struct mce *m)
 {
+	if (quirk_noprint && quirk_noprint(m))
+		return;
+
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
 		 m->extcpu,
 		 (m->mcgstatus & MCG_STATUS_MCIP ? " Exception" : ""),
@@ -1622,6 +1627,15 @@ static void quirk_sandybridge_ifu(int bank, struct=
 mce *m, struct pt_regs *regs)
 	m->cs =3D regs->cs;
 }
=20
+static int quirk_spurious_ce_noprint(struct mce *m)
+{
+	if (m->bank =3D=3D 0 &&
+	    (m->status & 0xa0000000ffffffff) =3D=3D 0x80000000000f0005)
+		return 1;
+
+	return 0;
+}
+
 /* Add per CPU specific workarounds here */
 static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
@@ -1696,6 +1710,13 @@ static int __mcheck_cpu_apply_quirks(struct cpuinf=
o_x86 *c)
=20
 		if (c->x86 =3D=3D 6 && c->x86_model =3D=3D 45)
 			quirk_no_way_out =3D quirk_sandybridge_ifu;
+
+		if ((c->x86 =3D=3D 6) &&
+		    ((c->x86_model =3D=3D 0x3c) || (c->x86_model =3D=3D 0x3d) ||
+		     (c->x86_model =3D=3D 0x45) || (c->x86_model =3D=3D 46))) {
+			pr_info("MCE errata HSD131, HSM142, HSW131, BDM48, or HSM142 enabled.=
\n");
+			quirk_noprint =3D quirk_spurious_ce_noprint;
+		}
 	}
=20
 	if (c->x86_vendor =3D=3D X86_VENDOR_ZHAOXIN) {
--=20
2.21.1

