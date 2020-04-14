Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92F1A8632
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391893AbgDNQzV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 12:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407502AbgDNQtI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:08 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFEA72173E;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=YrKwSCyyL6nlO0cCOhfxnQbvUXb9v0CXNYMRM9FudAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vC9w/aWhRSvJzEWvqp/+8HBpOE05Rop9NhSD8fG/HHnDnGOoI4fun1mFi0crcPr0T
         uNrsfDAn0wYjfWyrRsQti9AtkVu6E2KDr+Q2T5oG1UrTaDJ0RaukL+kFIpFiCAWusZ
         VT+gHup0ClB4WCphgIDBIiyG9I8b78X2whyk60S8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068m3-0x; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH v2 15/33] docs: ras: get rid of some warnings
Date:   Tue, 14 Apr 2020 18:48:41 +0200
Message-Id: <9e1bb44d6dbedb5b6f049d081b47da1f9620de16.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.25.2

