Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F346164520
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2020 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBSNQx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Feb 2020 08:16:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54108 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726530AbgBSNQx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Feb 2020 08:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582118212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EZeX/sR4EMAk2QlfO8plMdFFOB0OohNSKOrhSwQkcdA=;
        b=BVakiy4FHJQo2E2CeKswOsQ9QH9zNIy33r3LipCFwt0SwXj2aJbWouaofGveOqOHI7/TqP
        2Ucy9xEolhB7XPONblok0AUMqFgOQ0PPw3kWhWNRKo0tjK1CuCRFQilZAQKYjzLF/rwgBl
        afjiyY6a5ikWah58mZxhXpIXe2oASFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-J9pVqpnQNe-FnyV9qyGlig-1; Wed, 19 Feb 2020 08:16:45 -0500
X-MC-Unique: J9pVqpnQNe-FnyV9qyGlig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7F52DB60;
        Wed, 19 Feb 2020 13:16:43 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDB78B56B;
        Wed, 19 Feb 2020 13:16:42 +0000 (UTC)
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
Subject: [PATCH v3] x86/mce: Do not log spurious corrected mce errors
Date:   Wed, 19 Feb 2020 08:16:11 -0500
Message-Id: <20200219131611.36816-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A user has reported that they are seeing spurious corrected errors on
their hardware.

Intel Errata HSD131, HSM142, HSW131, and BDM48 report that
"spurious corrected errors may be logged in the IA32_MC0_STATUS register
with the valid field (bit 63) set, the uncorrected error field (bit 61)
not set, a Model Specific Error Code (bits [31:16]) of 0x000F, and
an MCA Error Code (bits [15:0]) of 0x0005."  The Errata PDFs are linked i=
n
the bugzilla below.

Block these spurious errors from the console and logs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206587
Co-developed-by: Alexander Krupp <centos@akr.yagii.de>
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
v2: Fix intel_filter_mce() declaration
v3: Fix !CONFIG_X86_MCE_INTEL compile

 arch/x86/kernel/cpu/mce/core.c     |  2 ++
 arch/x86/kernel/cpu/mce/intel.c    | 17 +++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  5 +++++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
index 2c4f949611e4..fe3983d551cc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1877,6 +1877,8 @@ bool filter_mce(struct mce *m)
 {
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
 		return amd_filter_mce(m);
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		return intel_filter_mce(m);
=20
 	return false;
 }
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/in=
tel.c
index 5627b1091b85..989148e6746c 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -520,3 +520,20 @@ void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
 }
+
+bool intel_filter_mce(struct mce *m)
+{
+	struct cpuinfo_x86 *c =3D &boot_cpu_data;
+
+	/* MCE errata HSD131, HSM142, HSW131, BDM48, and HSM142 */
+	if ((c->x86 =3D=3D 6) &&
+	    ((c->x86_model =3D=3D INTEL_FAM6_HASWELL) ||
+	     (c->x86_model =3D=3D INTEL_FAM6_HASWELL_L) ||
+	     (c->x86_model =3D=3D INTEL_FAM6_BROADWELL) ||
+	     (c->x86_model =3D=3D INTEL_FAM6_HASWELL_G)) &&
+	    (m->bank =3D=3D 0) &&
+	    ((m->status & 0xa0000000ffffffff) =3D=3D 0x80000000000f0005))
+		return true;
+
+	return false;
+}
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce=
/internal.h
index b785c0d0b590..f6e0419969c5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -175,5 +175,10 @@ extern bool amd_filter_mce(struct mce *m);
 #else
 static inline bool amd_filter_mce(struct mce *m)			{ return false; };
 #endif
+#ifdef CONFIG_X86_MCE_INTEL
+extern bool intel_filter_mce(struct mce *m);
+#else
+static inline bool intel_filter_mce(struct mce *m) { return false; };
+#endif
=20
 #endif /* __X86_MCE_INTERNAL_H__ */
--=20
2.21.1

