Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20D6581A0E
	for <lists+linux-edac@lfdr.de>; Tue, 26 Jul 2022 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiGZTE5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Jul 2022 15:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiGZTE4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Jul 2022 15:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5464C326CA
        for <linux-edac@vger.kernel.org>; Tue, 26 Jul 2022 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658862294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Em43YBlGpD4Nb7ExErLSBmIS59vczgV4ujcOA8o45m8=;
        b=KZX7dItBA0UR8gXZL+8Q+Foa6TjMVRkRRbf5i33NqE7ofKRdbsq24UVHFhFuxWk8dwosoR
        RHfSWeyiCP2pkFAjyarcVn5Z4PpvwFSqlKGhbWxFlVKJPFmHZo95cYNgMzMnAgINfZfJN5
        /An2MWrOIeL25fD/o1ZkSHxRHNrs8xI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-c2uk0jwVMvWOFvQB3nxLlQ-1; Tue, 26 Jul 2022 15:04:50 -0400
X-MC-Unique: c2uk0jwVMvWOFvQB3nxLlQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2F669573A3;
        Tue, 26 Jul 2022 19:04:49 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9710D492CA2;
        Tue, 26 Jul 2022 19:04:49 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 58E12C04DD; Tue, 26 Jul 2022 15:04:49 -0400 (EDT)
Date:   Tue, 26 Jul 2022 15:04:49 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     linux-edac@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] i5000_edac: fix slot number passed to determine_mtr()
Message-ID: <20220726190449.6mwhxyar6vcyrvzl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When the logic mapping branch/slot/channel was reworked back in
64e1fdaf55d6 ("i5000_edac: Fix the logic that retrieves memory information")
i5000_init_csrows() was not updated and kept passing twice the number
of slots to determine_mtr(), which leads to acessing past the end of
i5000_pvt.b1_mtr[]. This was found by KASAN.

Fixes: 64e1fdaf55d6 ("i5000_edac: Fix the logic that retrieves memory information")
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Signed-off-by: Aristeu Rozanski <aris@redhat.com>

---
 drivers/edac/i5000_edac.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linus-2.6.orig/drivers/edac/i5000_edac.c	2022-07-25 15:26:40.093989879 -0400
+++ linus-2.6/drivers/edac/i5000_edac.c	2022-07-26 14:32:23.644694778 -0400
@@ -1249,14 +1249,12 @@ static int i5000_init_csrows(struct mem_
 	struct i5000_pvt *pvt;
 	struct dimm_info *dimm;
 	int empty;
-	int max_csrows;
 	int mtr;
 	int csrow_megs;
 	int channel;
 	int slot;
 
 	pvt = mci->pvt_info;
-	max_csrows = pvt->maxdimmperch * 2;
 
 	empty = 1;		/* Assume NO memory */
 
@@ -1267,7 +1265,7 @@ struct i5000_pvt *pvt;
 	 * to map the dimms. A good cleanup would be to remove this array,
 	 * and do a loop here with branch, channel, slot
 	 */
-	for (slot = 0; slot < max_csrows; slot++) {
+	for (slot = 0; slot < pvt->maxdimmperch; slot++) {
 		for (channel = 0; channel < pvt->maxch; channel++) {
 
 			mtr = determine_mtr(pvt, slot, channel);

-- 
Aristeu

