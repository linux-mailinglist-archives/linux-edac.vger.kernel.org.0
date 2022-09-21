Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4665D50FE
	for <lists+linux-edac@lfdr.de>; Wed, 21 Sep 2022 20:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiIUSKR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Sep 2022 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIUSKR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 21 Sep 2022 14:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AE4A105
        for <linux-edac@vger.kernel.org>; Wed, 21 Sep 2022 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663783814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QPOWo1x2Q3bZBJvf/RMV+nk/IY7PTjChXYr7c51rS48=;
        b=Jia8ZBNPYrAW51vtXXlNaN2s8ye4JeEjEGiLlwAXNLgqJI5wUDY2UesxyGwgco/TsVjwdm
        O0jLZyh5cTcBB15LrYf7S5aWW6chL9PIGmMRBeHGLO9CAhF14CQwAnbnXHsvhsqXvv4h9t
        9+pFboWG660EDrbRpWklJUPhWNJ+xVs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-mRIz5uSDP2SqLmw3FFR0bw-1; Wed, 21 Sep 2022 14:10:11 -0400
X-MC-Unique: mRIz5uSDP2SqLmw3FFR0bw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 584813817A67;
        Wed, 21 Sep 2022 18:10:10 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AA801121314;
        Wed, 21 Sep 2022 18:10:10 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id D18ECC04E2; Wed, 21 Sep 2022 14:10:09 -0400 (EDT)
Date:   Wed, 21 Sep 2022 14:10:09 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     linux-edac@vger.kernel.org
Cc:     mchehab@kernel.org, bp@suse.de, arozansk@redhat.com
Subject: [RESEND PATCH] i5000_edac: fix slot number passed to determine_mtr()
Message-ID: <20220921181009.oxytvicy6sry6it7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

