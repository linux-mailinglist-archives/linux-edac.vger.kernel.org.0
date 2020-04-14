Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D911A8623
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbgDNQyZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 12:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407505AbgDNQtO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD90217BA;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=qbLirr5OJzkGy9BaDKpusPauYxAyPeK4aOYcI5WQ1pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RML0oIb+532FiifWanRBbBBqIv+j5i6BLN6eFCYjNBQLfUhmR8G9N7lGqbtDNs9MC
         NTLde4a5YJXqn4dJfQiXPzmk0paODmzEs/QGA0mDvstdgQ1WkcfK8DUoVgFADduwx6
         BjhcIf3EhIqu6xHFgCEY/QUoiCh7IEb2An0Dn8lk=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068m8-20; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH v2 16/33] docs: ras: don't need to repeat twice the same thing
Date:   Tue, 14 Apr 2020 18:48:42 +0200
Message-Id: <f76dcae96de8b1bb8ee37a79781c111c825e26d6.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.25.2

