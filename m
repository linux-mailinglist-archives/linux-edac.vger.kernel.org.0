Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643115EDD1C
	for <lists+linux-edac@lfdr.de>; Wed, 28 Sep 2022 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiI1MsX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Sep 2022 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiI1MsW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Sep 2022 08:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC959275
        for <linux-edac@vger.kernel.org>; Wed, 28 Sep 2022 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664369301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWE7KfdcZtxhkWQU9uQ9pU8FY5mThZavTiu1UzdFtM4=;
        b=Au5UBdCU7EfoFnyhoJeucZkrea/R+LUvh752oLZdthhUEAm7kQ2CEVCat6Ulcq7fhV7ESh
        s5XxIjEnubNjyMUc6ziPjYErbJcvrw/xF5o+QQgaB1UsXX4smge5sZtps3fjILIPggPm+d
        3d21oq1PhqGCnj3XsOJsYmydsGwVrJk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-Si9dWJZtM--5SPJW6jAR5g-1; Wed, 28 Sep 2022 08:48:16 -0400
X-MC-Unique: Si9dWJZtM--5SPJW6jAR5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B9C03817962;
        Wed, 28 Sep 2022 12:48:16 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E2B99D470;
        Wed, 28 Sep 2022 12:48:16 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 1E752C0502; Wed, 28 Sep 2022 08:48:15 -0400 (EDT)
Date:   Wed, 28 Sep 2022 08:48:15 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org
Subject: [PATCH] i5000_edac: mark as BROKEN
Message-ID: <20220928124815.ta6k4jiiyy6diudr@redhat.com>
References: <20220921181009.oxytvicy6sry6it7@redhat.com>
 <YytoHtVULW7w3/8Z@zn.tnic>
 <20220922134659.biiy6g743qplzgiq@redhat.com>
 <YyxpbRkuLPIcW1Om@zn.tnic>
 <20220926165138.kyp24vhh2czvmu2z@redhat.com>
 <YzHpRLVHc+ykfhY7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzHpRLVHc+ykfhY7@zn.tnic>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

i5000_edac supports very old hardware which isn't available and it's
been broken for single/dual channel for many years without anyone
noticing. Marking as BROKEN.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 17562cf1fe97..e659e4712a25 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -211,6 +211,7 @@ config EDAC_R82600
 config EDAC_I5000
 	tristate "Intel Greencreek/Blackford chipset"
 	depends on X86 && PCI
+	depends on BROKEN
 	help
 	  Support for error detection and correction the Intel
 	  Greekcreek/Blackford chipsets.

