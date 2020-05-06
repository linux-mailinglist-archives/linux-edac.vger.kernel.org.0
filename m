Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0762D1C7629
	for <lists+linux-edac@lfdr.de>; Wed,  6 May 2020 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgEFQWk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 May 2020 12:22:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59723 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729646AbgEFQWk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 May 2020 12:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588782159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4PV/Oz9EMaoWYDCKWTdS/bfutUurWUHFj9d/731Bm6E=;
        b=HhEdYa+rX571XY/tyF5CrRv4FmPpQp356gewM4eErEj3qxkYNQQr9wXdNCJOzR4jRwSiuD
        Xg3I7OEgQ1eqgVLdj+wlHQT4dVvgVxo+YR3+NhRhmfgqTiHDQfkufVeHDKQJC3GwKuktTy
        2eHm0XeN8PkRDTbpnh8JR5pBiF83y9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-gJigIv7SPMKEEwb3l5i1Sg-1; Wed, 06 May 2020 12:22:35 -0400
X-MC-Unique: gJigIv7SPMKEEwb3l5i1Sg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A32980183C;
        Wed,  6 May 2020 16:22:32 +0000 (UTC)
Received: from llong.com (ovpn-116-141.rdu2.redhat.com [10.10.116.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55BEF6E71B;
        Wed,  6 May 2020 16:22:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Cc:     linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] doc: Fix some errors in ras.rst
Date:   Wed,  6 May 2020 12:22:17 -0400
Message-Id: <20200506162217.16633-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Make some miscellaneous fixes to the first paragraph of "ECC memory":
 - Change the incorrect "74 bits" to "72 bits".
 - Change "mentioned on" to "mentioned in".
 - Remove the extra "extra".
 - Rephrase some sentences as suggested by Matthew Wilcox.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/ras.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 0310db624964..e48f6bcf305b 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -156,11 +156,11 @@ the labels provided by the BIOS won't match the real ones.
 ECC memory
 ----------
 
-As mentioned on the previous section, ECC memory has extra bits to be
-used for error correction. So, on 64 bit systems, a memory module
-has 64 bits of *data width*, and 74 bits of *total width*. So, there are
-8 bits extra bits to be used for the error detection and correction
-mechanisms. Those extra bits are called *syndrome*\ [#f1]_\ [#f2]_.
+As mentioned in the previous section, ECC memory has extra bits to be
+used for error correction. In the above example, a memory module has
+64 bits of *data width*, and 72 bits of *total width*.  The extra 8
+bits which are used for the error detection and correction mechanisms
+are referred to as the *syndrome*\ [#f1]_\ [#f2]_.
 
 So, when the cpu requests the memory controller to write a word with
 *data width*, the memory controller calculates the *syndrome* in real time,
-- 
2.18.1

