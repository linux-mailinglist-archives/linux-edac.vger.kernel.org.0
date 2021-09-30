Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AE241D6A0
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbhI3Jqq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 05:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349514AbhI3Jqo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Sep 2021 05:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB83A615E5;
        Thu, 30 Sep 2021 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995101;
        bh=oDk3Xte6LUuXxMEKmNTpij3KGwX2DRHuVkgkafiYT9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uByD8y42+qnvmla5BX2u4BZw1rk3Gpgp9zdF4BDRMwrkgfyOfafr4ucktROB64rp4
         /LJqRSrWnE0ozJiLltEeemydgAdM4CXCy95w35lb0g/QP+f0t7+NhyqoqpS1BZ15+I
         oCaFNbNA3Dx4e2UrhLWs5P3Tcvy1ckP1E2+IvT9y/vKlOPAbiB6A50ubx2BZSfXHvj
         9Rrh6aGIBtK9KbgSma0ggwVsrLCNfZcKX5Q3JGndhCo1pUPA8vW53hYe4Gj8E6aPZq
         C2zUz/n45vX+rL2JWEjTb6dx9m85JxqQeQx5b8vn61LRPRv88gtEVtnE0oM9UsVwI+
         +6bxMQ52vM2Xg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVscd-002ATK-PE; Thu, 30 Sep 2021 11:44:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] ABI: sysfs-mce: add 3 missing files
Date:   Thu, 30 Sep 2021 11:44:52 +0200
Message-Id: <f9c13aff3f5a2cae0d4495eccd17f431f3a4c55a.1632994837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632994837.git.mchehab+huawei@kernel.org>
References: <cover.1632994837.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Changeset 62fdac5913f7 ("x86, mce: Add boot options for corrected errors")
added three more MCE files that are also exposed currently via
sysfs.

Document them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1632994837.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-mce | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-mce b/Documentation/ABI/testing/sysfs-mce
index 686fbfa02cdc..c8cd989034b4 100644
--- a/Documentation/ABI/testing/sysfs-mce
+++ b/Documentation/ABI/testing/sysfs-mce
@@ -105,3 +105,25 @@ Description:
 
 		Unit: us
 
+What:		/sys/devices/system/machinecheck/machinecheckX/ignore_ce
+Contact:	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+Date:		Jun 2009
+Description:
+		Disables polling and CMCI for corrected errors.
+		All corrected events are not cleared and kept in bank MSRs.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/dont_log_ce
+Contact:	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+Date:		Jun 2009
+Description:
+		Disables logging for corrected errors.
+		All reported corrected errors will be cleared silently.
+
+		This option will be useful if you never care about corrected
+		errors.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/cmci_disabled
+Contact:	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+Date:		Jun 2009
+Description:
+		Disables the CMCI feature.
-- 
2.31.1

