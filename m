Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1145EAF62
	for <lists+linux-edac@lfdr.de>; Mon, 26 Sep 2022 20:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiIZSOO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Sep 2022 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiIZSNl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Sep 2022 14:13:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A819FB86A
        for <linux-edac@vger.kernel.org>; Mon, 26 Sep 2022 11:02:50 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e74d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e74d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0EA4E1EC01CE;
        Mon, 26 Sep 2022 20:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664215365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vd7kOjHANnEz1wBY2DAgl+7J8C6yS8LlIq2WwxdlGHU=;
        b=Oa0+Uom1kjkXRWbHiQkd6ZtshnQ977/5lbYT7sMCpvepHEWlgq1yfrx18sXkxXaQg+DMf+
        5L1cSzTF2i9KewMGEh2WG9WiwshercPkjoJvevQlYHJUyCRdlKd3kg210XFqJC7UgyQSGF
        SasXS6STfobs0BBcxQdbUShHODPd4WY=
Date:   Mon, 26 Sep 2022 20:02:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@redhat.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org
Subject: Re: [RESEND PATCH] i5000_edac: fix slot number passed to
 determine_mtr()
Message-ID: <YzHpRLVHc+ykfhY7@zn.tnic>
References: <20220921181009.oxytvicy6sry6it7@redhat.com>
 <YytoHtVULW7w3/8Z@zn.tnic>
 <20220922134659.biiy6g743qplzgiq@redhat.com>
 <YyxpbRkuLPIcW1Om@zn.tnic>
 <20220926165138.kyp24vhh2czvmu2z@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220926165138.kyp24vhh2czvmu2z@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 26, 2022 at 12:51:38PM -0400, Aristeu Rozanski wrote:
> Declare it dead. Only have a single working system and I don't have
> physical access to it along with the fact it's unlikely we have memory
> modules single and dual rank to swap around for testing purposes.

Wanna send a "depends on BROKEN" patch and explain why we're doing that
in the commit message?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
