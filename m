Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB717794C
	for <lists+linux-edac@lfdr.de>; Tue,  3 Mar 2020 15:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgCCOkM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Mar 2020 09:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbgCCOkM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 3 Mar 2020 09:40:12 -0500
Received: from mail.kernel.org (x2f7fa80.dyn.telefonica.de [2.247.250.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEEFF20842;
        Tue,  3 Mar 2020 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583246412;
        bh=OLtvri7lhnPMBPe2kuKdN8A2xr5mHeejJQsjos9PaT4=;
        h=From:To:Cc:Subject:Date:From;
        b=soQZS0PFPpb8dUqmzdhsEesrugGrP0eZXheu+g7uoWeoNg2UIVB3dqMjcrplvsndz
         E3XOO8IujDiOdMXpH1/DDyuNxlHg8FJpfI0tZ4+XdP0gBElXPpcyL1T098hAfIhD2S
         dK4kqE2pPhdGYZalpbUMK0EaCQSEG/KL3vjRySog=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j98iP-001Z0l-Eu; Tue, 03 Mar 2020 15:40:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-edac@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/2] docs: ras: get rid of some warnings
Date:   Tue,  3 Mar 2020 15:40:07 +0100
Message-Id: <0008bd9f16d5d02148501f5a1ba873245af1cab7.1583246400.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Sphinx produce some warnings due to a bad table format:

    Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.

Rearrange the things there in order to supress the warnings
while being precise at the Sphinx output about how ranks are
mapped into csrows.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/ras.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 0310db624964..22b31bc7e129 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -351,15 +351,17 @@ controllers. The following example will assume 2 channels:
 	+------------+-----------+-----------+
 	|            |  ``ch0``  |  ``ch1``  |
 	+============+===========+===========+
-	| ``csrow0`` |  DIMM_A0  |  DIMM_B0  |
-	|            |   rank0   |   rank0   |
-	+------------+     -     |     -     |
+	|            |**DIMM_A0**|**DIMM_B0**|
+	+------------+-----------+-----------+
+	| ``csrow0`` |   rank0   |   rank0   |
+	+------------+-----------+-----------+
 	| ``csrow1`` |   rank1   |   rank1   |
 	+------------+-----------+-----------+
-	| ``csrow2`` |  DIMM_A1  | DIMM_B1   |
-	|            |   rank0   |   rank0   |
-	+------------+     -     |     -     |
-	| ``csrow3`` |   rank1   |   rank1   |
+	|            |**DIMM_A1**|**DIMM_B1**|
+	+------------+-----------+-----------+
+	| ``csrow2`` |    rank0  |  rank0    |
+	+------------+-----------+-----------+
+	| ``csrow3`` |    rank1  |  rank1    |
 	+------------+-----------+-----------+
 
 In the above example, there are 4 physical slots on the motherboard
-- 
2.24.1

