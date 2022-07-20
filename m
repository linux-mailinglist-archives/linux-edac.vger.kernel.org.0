Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6353357BAA1
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiGTPko (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbiGTPkn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 11:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1697748EBD
        for <linux-edac@vger.kernel.org>; Wed, 20 Jul 2022 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658331641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GuN8kfto5JsiI6BBNXJp0Pu9KYAobQVtw9ohMJjp4U=;
        b=LKLBJIam+eLYmMZRKPeohGfJ4rja+CnNjKBZYu+ueyhC/4D+WY05iu4XLS+9r5ulq6ARzf
        FqW1b1sN+6miWfbxkil4a8NepberBUedZzeBniK6Q7XtLkfy72ipzqDz2MAc89mbgkNqgK
        h+1L5Q258u2MQNWToBkI3g8fWhswc3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-WRbBsgEXO1WSqpZXg3kUdQ-1; Wed, 20 Jul 2022 11:40:34 -0400
X-MC-Unique: WRbBsgEXO1WSqpZXg3kUdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 129291051623;
        Wed, 20 Jul 2022 15:40:34 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0558840C141D;
        Wed, 20 Jul 2022 15:40:34 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id C40A4C0521; Wed, 20 Jul 2022 11:40:33 -0400 (EDT)
Date:   Wed, 20 Jul 2022 11:40:33 -0400
From:   arozansk@redhat.com
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
Subject: [PATCH 3/3 v2] rasdaemon: ras-memory-failure-handler: handle
 localtime() failure correctly
Message-ID: <20220720154033.6kup6lark2ddwlrr@redhat.com>
References: <20220720143957.795358633@redhat.com>
 <20220720143957.977427150@redhat.com>
 <MW5PR84MB1842E4A18E672F6E13896D0CAB8E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842E4A18E672F6E13896D0CAB8E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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

v2: fixed the timestamp as pointed by Robert Elliott

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
+		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000", sizeof(ev.timestamp));
 	trace_seq_printf(s, "%s ", ev.timestamp);
 
 	if (pevent_get_field_val(s,  event, "pfn", record, &val, 1) < 0)

