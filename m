Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278AA57B89E
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 16:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiGTOkD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGTOkC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 10:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 257762B186
        for <linux-edac@vger.kernel.org>; Wed, 20 Jul 2022 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658328001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kBoBnHcQRgLrEstbVYYSM/6wH/EByp6aFCTHwOFX7Ts=;
        b=Uva0G8gw9bBffrfq2f6cF6w+vOcClAzpTMe/lSMBJuNrL/g5veUUMINLyLeQsnG/D/BcnS
        tevuD2Ppyck0GFupTdYOzI4txhvlvuBgE1nzsXXk4kZzcRKdBU9n4kOr4t1Jg4CWsg7xS1
        f7023Sc13KcBMwwoKbyIo4vBsZzSyM0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-S5Md_lOeO-WWbBINxU2FCQ-1; Wed, 20 Jul 2022 10:39:59 -0400
X-MC-Unique: S5Md_lOeO-WWbBINxU2FCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 227CD1C1BD23;
        Wed, 20 Jul 2022 14:39:58 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 159E818EA8;
        Wed, 20 Jul 2022 14:39:58 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id D345FC0521; Wed, 20 Jul 2022 10:39:57 -0400 (EDT)
Message-ID: <20220720143957.795358633@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 20 Jul 2022 10:39:57 -0400
From:   arozansk@redhat.com
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org
Subject: [PATCH 0/3] rasdaemon: misc fixes
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

These patches are for 3 issues found with covscan. None of them are likely to
happen during regular use, but worth fixing anyway.

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>

-- 
Aristeu

