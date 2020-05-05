Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836BE1C5AAC
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgEEPLJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 11:11:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26020 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729261AbgEEPLI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 May 2020 11:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588691467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QDdz0u1MDabvWLnuf8Me9gjoJIrk3ictomM8OSd7hgE=;
        b=F4fJb9fUnn9wLhSrCoiiHaWvW/6fc2eumXUU59lyAcwb8PlPj82IW7cIzPYAF5TD6jdZwV
        qx4arJ4Uf44VyeX281Iv3HOv4iLqr0AzCQcKaUF+IAVPOI3hpKh9XR7R6au6QrR83SpaxA
        t6aE37p3pQziAJ+Y7hCkoDGg3dFLO/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-UqbHH1zxM6yBvkxPJMqzEA-1; Tue, 05 May 2020 11:11:05 -0400
X-MC-Unique: UqbHH1zxM6yBvkxPJMqzEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E690A872FEA;
        Tue,  5 May 2020 15:11:03 +0000 (UTC)
Received: from llong.com (ovpn-114-81.rdu2.redhat.com [10.10.114.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4D295D9D5;
        Tue,  5 May 2020 15:10:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Cc:     linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] doc: Fix some typo errors in ras.rst
Date:   Tue,  5 May 2020 11:10:49 -0400
Message-Id: <20200505151049.11134-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix typo errors.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/ras.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 0310db624964..8b1803b2606f 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -156,10 +156,10 @@ the labels provided by the BIOS won't match the real ones.
 ECC memory
 ----------
 
-As mentioned on the previous section, ECC memory has extra bits to be
-used for error correction. So, on 64 bit systems, a memory module
-has 64 bits of *data width*, and 74 bits of *total width*. So, there are
-8 bits extra bits to be used for the error detection and correction
+As mentioned on the previous section, ECC memory has extra bits to
+be used for error correction. So, on 64 bit systems, a memory module
+has 64 bits of *data width*, and 72 bits of *total width*. So, there
+are 8 extra bits to be used for the error detection and correction
 mechanisms. Those extra bits are called *syndrome*\ [#f1]_\ [#f2]_.
 
 So, when the cpu requests the memory controller to write a word with
-- 
2.18.1

