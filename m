Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1357417794A
	for <lists+linux-edac@lfdr.de>; Tue,  3 Mar 2020 15:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgCCOkM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Mar 2020 09:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgCCOkM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 3 Mar 2020 09:40:12 -0500
Received: from mail.kernel.org (x2f7fa80.dyn.telefonica.de [2.247.250.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCFE52083E;
        Tue,  3 Mar 2020 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583246412;
        bh=fOlAZzT1uFFH2gmcV3PqAjmawyfv+6vChFB4f6HcX6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWTOYxjnCu92lmoa9T9HTuAhtIZuaFFCkQIoH3cM4DzZr6FxHQWC+LA+wsyT2Es8n
         lhcSqQ+cOCtlQrg1/0alSe0fyRm/ZsiVMMROCNvmy0tw8Pfqmvk/TDh0uyK9LA+XF5
         8zPNnRVAd5J1krFCGBXk3cYpUYmNp25o2ASOkPgU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j98iP-001Z0o-Fy; Tue, 03 Mar 2020 15:40:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-edac@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/2] docs: ras: don't need to repeat twice the same thing
Date:   Tue,  3 Mar 2020 15:40:08 +0100
Message-Id: <a295d46b8a1015f8882109cde26a086b19d92811.1583246400.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0008bd9f16d5d02148501f5a1ba873245af1cab7.1583246400.git.mchehab+huawei@kernel.org>
References: <0008bd9f16d5d02148501f5a1ba873245af1cab7.1583246400.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

We don't need to say twice "for the first time" at the same
paragraph.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/ras.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 22b31bc7e129..6cbaab975ee5 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -212,7 +212,7 @@ EDAC - Error Detection And Correction
    purposes.
 
    When the subsystem was pushed upstream for the first time, on
-   Kernel 2.6.16, for the first time, it was renamed to ``EDAC``.
+   Kernel 2.6.16, it was renamed to ``EDAC``.
 
 Purpose
 -------
-- 
2.24.1

