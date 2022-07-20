Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6977857B8A1
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 16:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiGTOkL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGTOkK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 10:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1472DEBA
        for <linux-edac@vger.kernel.org>; Wed, 20 Jul 2022 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658328008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4R6On8bij0HV7pbO2X7JiLRzPOTfeLFbAfRAz4bkGvE=;
        b=DanYZJJ0o30kvHRJq8SQ2OpJzljpt8bs036M287TZaeqlFO6yP+Y9IPCb2MJBzQ70a1JH0
        8Yb4GkGy0l8LIGnj7LDk422N57XSmiSL3JZ8dIgZQUcRpGDjQ/waoZyqoiL00a81r7dpuw
        6J7/7tKfO4kSS4FsGdwR1NqJ7UjPExI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-96xl2yrcN5-ZYoD-yM9VtQ-1; Wed, 20 Jul 2022 10:39:58 -0400
X-MC-Unique: 96xl2yrcN5-ZYoD-yM9VtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D30C18A658E;
        Wed, 20 Jul 2022 14:39:58 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20AF290A11;
        Wed, 20 Jul 2022 14:39:58 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id DF01DC0523; Wed, 20 Jul 2022 10:39:57 -0400 (EDT)
Message-ID: <20220720143957.868734458@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 20 Jul 2022 10:39:58 -0400
From:   arozansk@redhat.com
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org, Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH 1/3] rasdaemon: ras-report: fix possible but unlikely file descriptor leak
References: <20220720143957.795358633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Found with covscan.

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

diff --git a/ras-report.c b/ras-report.c
index ea3a9b6..0088745 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -768,7 +768,7 @@ int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev)
 	done = 1;
 
 mf_fail:
-	if (sockfd > 0)
+	if (sockfd >= 0)
 		close(sockfd);
 
 	if (done)

