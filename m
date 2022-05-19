Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4071852CF79
	for <lists+linux-edac@lfdr.de>; Thu, 19 May 2022 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiESJea (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 May 2022 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiESJe3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 May 2022 05:34:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C769CF9;
        Thu, 19 May 2022 02:34:28 -0700 (PDT)
Received: from zn.tnic (p200300ea97465796329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5796:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7D261EC026E;
        Thu, 19 May 2022 11:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652952862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+HJOUklWEgaDoZskeuIvxgcY23FPjNPeUff3VsXcslQ=;
        b=VWLvtmtrTdG7/K5Z9qJAUc9htYxcGcX2oAiIFEqrSn8G9lZUAudUkIQ8SlSL64AbsXoUHK
        nfBdKt2ZGh4AYOsIvoI5DT30JEQD/bXIASpAl0VHlar9VN5lLfwqaNKLeHttqZHlsHu1UJ
        WVV3GfOlcspTukpooW6Pw5RzA7nYpLQ=
Date:   Thu, 19 May 2022 11:34:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Medad Young <medadyoung@gmail.com>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v9 1/3] ARM: dts: nuvoton: Add memory controller node
Message-ID: <YoYPGWreQuF9QZzc@zn.tnic>
References: <20220510031056.1657-1-ctcchien@nuvoton.com>
 <20220510031056.1657-2-ctcchien@nuvoton.com>
 <YoUwe6Tj4Uh6ukc8@zn.tnic>
 <CAHpyw9fjThEP4NuU08aNJ_raHpq9-j9KgBb8YuZ_shXTjhm3JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHpyw9fjThEP4NuU08aNJ_raHpq9-j9KgBb8YuZ_shXTjhm3JA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 19, 2022 at 08:55:53AM +0800, Medad Young wrote:
> OK, I got it.

Are you sure you did get it?

$ ./scripts/checkpatch.pl /tmp/medad-v10-1-3.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#29: 
new file mode 100644

WARNING: From:/Signed-off-by: email address mismatch: 'From: Medad CChien <medadyoung@gmail.com>' != 'Signed-off-by: Medad CChien <ctcchien@nuvoton.com>'

total: 0 errors, 2 warnings, 62 lines checked

Before sending, you should really run checkpatch on your patches.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
