Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3C15D779
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2020 13:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgBNMeS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Feb 2020 07:34:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728336AbgBNMeS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Feb 2020 07:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581683656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UHjWhhdV2+UpvRSK8mb67ax9eLchJ76I0gg6jINgDIU=;
        b=PPkD1VvMZ7MoTCqhsO11Etd/pTMek4Kd7gTkcJykxvZXEA61G8Ol9fXKCPLVPKbVz689DX
        jUS9dujeBa6QsBXt6KcRX3d+TcujEtjJgHf9I5VvmlNPwq4aO1bBpxXUMQeGNupKNPXy8H
        +GCtt7HJ2f7zQOcHY2TlucYTDYrWJcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-1HXq3ucgNhewtMFEc02SpQ-1; Fri, 14 Feb 2020 07:34:13 -0500
X-MC-Unique: 1HXq3ucgNhewtMFEc02SpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3306F107ACC7;
        Fri, 14 Feb 2020 12:34:11 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EAFE5DA7D;
        Fri, 14 Feb 2020 12:34:09 +0000 (UTC)
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
Subject: [PATCH] x86/mce: Do not log spurious corrected mce errors
Date:   Fri, 14 Feb 2020 07:34:07 -0500
Message-Id: <20200214123407.4184-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Alex has reported that he is seeing spurious corrected errors on
his hardware.

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

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Co-developed-by: Alexander Krupp <centos@akr.yagii.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-edac@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/core.c     |  2 ++
 arch/x86/kernel/cpu/mce/intel.c    | 17 +++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 21 insertions(+)

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
index b785c0d0b590..2729db355b36 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -172,8 +172,10 @@ extern bool filter_mce(struct mce *m);
=20
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
+extern bool intel_filter_mce(struct mce *m);
 #else
 static inline bool amd_filter_mce(struct mce *m)			{ return false; };
+static inline bool intel_filter_mce(struct mce *m)			{ return false; };
 #endif
=20
 #endif /* __X86_MCE_INTERNAL_H__ */
--=20
2.21.1

