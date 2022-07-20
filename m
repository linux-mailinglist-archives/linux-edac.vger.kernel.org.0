Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745BF57B89F
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 16:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiGTOkE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGTOkD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 10:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47A7D2B186
        for <linux-edac@vger.kernel.org>; Wed, 20 Jul 2022 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658328002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bL142uVpJExVyLMHAw4Afa1YfkEk/t35n231UjbltVQ=;
        b=hUUoWAcjGQPzaEF2vYr50wKkBMyacGO5j2kSw3xGgMQi3XTftwDcX3/9y42DmFsk/nErgH
        D/XcY37cy1hSutx+5BgWNiuCdQ5Y0GZCk0D+olZlpuP+jnvEknKxRCkBvce8SHJ8qpKo4e
        aJ6g6c5OxY8P5pnfRFC9iQ1P9rlzRVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-g3zPPdFBNPybj_yDZ5P6ow-1; Wed, 20 Jul 2022 10:39:58 -0400
X-MC-Unique: g3zPPdFBNPybj_yDZ5P6ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38109858EED;
        Wed, 20 Jul 2022 14:39:58 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BCCE400DFD7;
        Wed, 20 Jul 2022 14:39:58 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id EC609C0554; Wed, 20 Jul 2022 10:39:57 -0400 (EDT)
Message-ID: <20220720143957.923005739@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 20 Jul 2022 10:39:59 -0400
From:   arozansk@redhat.com
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org, Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH 2/3] rasdaemon: mce-amd-smca: properly limit bank types
References: <20220720143957.795358633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Found with covscan.

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index f3379fc..27ca8aa 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -584,7 +584,7 @@ static void decode_smca_error(struct mce_event *e)
 		return;
 	}
 
-	if (bank_type >= MAX_NR_BANKS) {
+	if (bank_type >= N_SMCA_BANK_TYPES) {
 		strcpy(e->mcastatus_msg, "Don't know how to decode this bank");
 		return;
 	}

