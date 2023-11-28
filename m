Return-Path: <linux-edac+bounces-124-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243567FBC9E
	for <lists+linux-edac@lfdr.de>; Tue, 28 Nov 2023 15:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5505C1C20A66
	for <lists+linux-edac@lfdr.de>; Tue, 28 Nov 2023 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636A5ABB3;
	Tue, 28 Nov 2023 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lQQbbVM5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF877C1;
	Tue, 28 Nov 2023 06:21:09 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5C4F40E0031;
	Tue, 28 Nov 2023 14:21:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FkzHQZ5LqZ19; Tue, 28 Nov 2023 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1701181262; bh=djgexPykShCCOWmlqzQx+qXNGN05nNP+MDkkppHP5vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQQbbVM53H/aJ4N6bEkQJVcO39J/ja2tSgX0+UKo4glNWsK1sRo6EyH/7vu4JrU/M
	 2WiDTGS7ddwGD8InQN2D0MqmxbYK0++1EKCoCMHc63DH3Xb1BdZ8rO0EEB8NuSCkH1
	 kFefNmZnA9w7gtNhal55lIUuA7THvTekO9Bh/arDViTpE2ExivXbojg5OL2/wivvxE
	 HQGiuD9BtypuL9wt2iwuQbOek0NXg7HsqqJ0C9RKFC+rt/qJ9Ldzwnq5HSB9N7DKLO
	 0IaquxV3lWw7dNgZw8eoFtkGOvWLEx8QZy+aqVgzZcZmlLVVNIZDyAR4XE6w4r99c1
	 xc9X548TgjfaIRKSkOmU58I6eW6bLkIYxaYmejprmT9j8Zrbfm7CrkAAUBe6EWYKrA
	 UyP+EK72F/bHMsT8K60Yw+BwaVg87EYxPa/3UKmYnPpSB2pj773f1x7r9ggrw0caJv
	 p1NxT1a3P6w5z9eY+d4/KE4gTcIghWfKWQzvSGoJWr0+Tec+BqUeT7sj1Vh8pp7AVE
	 QxvJk71VZEco5RkCVOvz2xGs1wlQTvpO7h9WS1b5GkwPhAy6p8xNg2CY1N7Z/9g16T
	 pv0V88ZHfrbneNVmtodespieQ0pmK+l2xefiE33pDiLzJmS8KoQVs3Hyu8ajDDdLls
	 8y3W0AiTuTZvZx0aS6tCfkXI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DF9040E01A5;
	Tue, 28 Nov 2023 14:20:55 +0000 (UTC)
Date: Tue, 28 Nov 2023 15:20:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muralidhara M K <muralidhara.mk@amd.com>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: Begin a RAS section
Message-ID: <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102114225.2006878-2-muralimk@amd.com>

On Thu, Nov 02, 2023 at 11:42:22AM +0000, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> AMD systems with Scalable MCA, each machine check error of a SMCA bank
> type has an associated bit position in the bank's control (CTL) register.

Ontop of this. It is long overdue:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 28 Nov 2023 14:37:56 +0100

Add some initial RAS documentation. The expectation is for this to
collect all the user-visible features for interacting with the RAS
features of the kernel.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/RAS/ras.rst | 26 ++++++++++++++++++++++++++
 Documentation/index.rst   |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/RAS/ras.rst

diff --git a/Documentation/RAS/ras.rst b/Documentation/RAS/ras.rst
new file mode 100644
index 000000000000..2556b397cd27
--- /dev/null
+++ b/Documentation/RAS/ras.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Reliability, Availability and Serviceability features
+=====================================================
+
+This documents different aspects of the RAS functionality present in the
+kernel.
+
+Error decoding
+---------------
+
+* x86
+
+Error decoding on AMD systems should be done using the rasdaemon tool:
+https://github.com/mchehab/rasdaemon/
+
+While the daemon is running, it would automatically log and decode
+errors. If not, one can still decode such errors by supplying the
+hardware information from the error::
+
+        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca
+
+Also, the user can pass particular family and model to decode the error
+string::
+
+        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca --family <CPU Family> --model <CPU Model> --bank <BANK_NUM>
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc826618c..36e61783437c 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -113,6 +113,7 @@ to ReStructured Text format, or are simply too old.
    :maxdepth: 1
 
    staging/index
+   RAS/ras
 
 
 Translations
-- 
2.42.0.rc0.25.ga82fb66fed25


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

