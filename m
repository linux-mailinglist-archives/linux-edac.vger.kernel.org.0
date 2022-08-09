Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D358D4DA
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiHIHu1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 03:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiHIHu0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 03:50:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7737B25FE;
        Tue,  9 Aug 2022 00:50:25 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E3531EC01B7;
        Tue,  9 Aug 2022 09:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660031419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CKTlBpVle+EMNM4GbiovFuYDC+EYIUhi9bVoDaoM+Hc=;
        b=AvQLi8gZPjJNC3y51S/pIeAEhLII8w6paYpTN+JUqd9cUaE2N2FI0oHRgYPY6cFtKd2Lmk
        /dgDyrdHauhZhn1SmxKfipFMlQ7JmgNEwsKsvWzBHMo8/vqDiHeONG/xahO6CpQfZWZhwp
        uaenCxHLp/HYxjUiIruj9w08iTmswZQ=
Date:   Tue, 9 Aug 2022 09:50:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     medadyoung@gmail.com, KWLIU@nuvoton.com, tony.luck@intel.com,
        rric@kernel.org, benjaminfair@google.com,
        linux-edac@vger.kernel.org, KFTING@nuvoton.com,
        avifishman70@gmail.com, venture@google.com,
        openbmc@lists.ozlabs.org, JJLIU0@nuvoton.com, ctcchien@nuvoton.com,
        tali.perry1@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, james.morse@arm.com, YSCHU@nuvoton.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        tmaimon77@gmail.com
Subject: Re: Referencing non-public datasheets in commit messages (was:
 [PATCH v12 3/3] EDAC: nuvoton: Add NPCM memory controller driver)
Message-ID: <YvIRusXsZvdiFRzS@zn.tnic>
References: <20220610084340.2268-1-ctcchien@nuvoton.com>
 <20220610084340.2268-4-ctcchien@nuvoton.com>
 <YrDIimW0gW1j03WG@zn.tnic>
 <6d1576c9-f105-2aff-4497-2c2e7bed2f3b@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d1576c9-f105-2aff-4497-2c2e7bed2f3b@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 09, 2022 at 08:42:29AM +0200, Paul Menzel wrote:
> Maybe it could be denoted, that is not public (and also the version), but
> even mentioning non-public datasheets is useful, as they could be made
> public in the future, and allows everyone to contact people with access to
> these datasheets to take a look into the specific datasheet.

If you're going to contact people to get you certain information, you
don't need the datasheet - you simply need to ask the question.

But whatever, if a document is mentioned, the text should state that it
is not public so that people are aware not to go looking for it. Or, if
it is public, how to find it.

And no, a company website URL is not a good idea because those change
pretty frequently in practice. Uploading to our bugzilla and adding the
link to it is much better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
