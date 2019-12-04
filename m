Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E154113706
	for <lists+linux-edac@lfdr.de>; Wed,  4 Dec 2019 22:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfLDVXe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Dec 2019 16:23:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727961AbfLDVXe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Dec 2019 16:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575494612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f/GutEbXrt3J4lLgyo9rDCe//Fbg+YlYpXmNcbhB7hY=;
        b=C2yrJVe14hCWULykAGC/1wmahCHGkMQczzPn9+x0V4zLgzUWgue50zwTed/Mt4FhMP/IEG
        i1QRZzYKrEw3q++p0/uupRVQUuOtU/HMds7c4amA4J53a8VnB/aSbOXl6V6YcvyBicD89y
        vzogqfQrMf0hgwObEKEY3bBrWuuLUK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-lcaVODWzMZW9kzZ94W6gUQ-1; Wed, 04 Dec 2019 16:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF410107ACC4;
        Wed,  4 Dec 2019 21:23:25 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C15BB5C21B;
        Wed,  4 Dec 2019 21:23:25 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 520B7C0D3A; Wed,  4 Dec 2019 16:23:25 -0500 (EST)
Date:   Wed, 4 Dec 2019 16:23:25 -0500
From:   Aristeu Rozanski <aris@redhat.com>
To:     linux-edac@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] EDAC: skx_common: downgrade message importance on missing
 PCI device
Message-ID: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lcaVODWzMZW9kzZ94W6gUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Both skx_edac and i10nm_edac drivers are loaded based on the matching CPU b=
eing
available which leads the module to be automatically loaded in virtual mach=
ines
as well. That will fail due the missing PCI devices. In both drivers the fi=
rst
function to make use of the PCI devices is skx_get_hi_lo() will simply prin=
t

=09EDAC skx: Can't get tolm/tohm

for each CPU core, which is noisy. This patch makes it a debug message.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 95662a4ff4c4..99bbaf629b8d 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -256,7 +256,7 @@ int skx_get_hi_lo(unsigned int did, int off[], u64 *tol=
m, u64 *tohm)
=20
 =09pdev =3D pci_get_device(PCI_VENDOR_ID_INTEL, did, NULL);
 =09if (!pdev) {
-=09=09skx_printk(KERN_ERR, "Can't get tolm/tohm\n");
+=09=09edac_dbg(2, "Can't get tolm/tohm\n");
 =09=09return -ENODEV;
 =09}
=20

