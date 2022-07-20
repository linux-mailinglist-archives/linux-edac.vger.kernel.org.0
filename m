Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22B357B8A0
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiGTOkJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGTOkH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 10:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED1B7CCB
        for <linux-edac@vger.kernel.org>; Wed, 20 Jul 2022 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658328005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JzZJ8/arweKn5Zbrtgd3CRnAoLDXWDayUI8QDnBw1SI=;
        b=huQrsKqsAjfR1dMs+yVxtocXBkAhQwBZGq/vJf2H4TN30dBGOmLf1GY93QOhwub8XsT8tk
        EzUGXeLUrfitTt8a/l5rNvYuAQAqKo4+iUDXmvgraNeTQ4f9/vWksXpKRC+ja4STyRFY+i
        gNhzosynq1HJ/6nJB8x6FsVmXGbCFzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-O2F7j_ggM8uWNyKhxUn56g-1; Wed, 20 Jul 2022 10:39:58 -0400
X-MC-Unique: O2F7j_ggM8uWNyKhxUn56g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4948D803520;
        Wed, 20 Jul 2022 14:39:58 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CFFB2166B26;
        Wed, 20 Jul 2022 14:39:58 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 05BFBC0568; Wed, 20 Jul 2022 10:39:58 -0400 (EDT)
Message-ID: <20220720143957.977427150@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 20 Jul 2022 10:40:00 -0400
From:   arozansk@redhat.com
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org, Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH 3/3] rasdaemon: ras-memory-failure-handler: handle localtime() failure correctly
References: <20220720143957.795358633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

We could just have an empty string but keeping the format could prevent
issues if someone is actually parsing this.
Found with covscan.

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

diff --git a/ras-memory-failure-handler.c b/ras-memory-failure-handler.c
index 9941e68..9574141 100644
--- a/ras-memory-failure-handler.c
+++ b/ras-memory-failure-handler.c
@@ -148,6 +148,8 @@ int ras_memory_failure_event_handler(struct trace_seq *s,
 	if (tm)
 		strftime(ev.timestamp, sizeof(ev.timestamp),
 			 "%Y-%m-%d %H:%M:%S %z", tm);
+	else
+		strncpy(ev.timestamp, "0000-00-00 00:00:00 GMT", sizeof(ev.timestamp));
 	trace_seq_printf(s, "%s ", ev.timestamp);
 
 	if (pevent_get_field_val(s,  event, "pfn", record, &val, 1) < 0)

