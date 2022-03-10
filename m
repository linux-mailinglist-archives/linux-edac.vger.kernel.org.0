Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24FA4D4E14
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 17:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiCJQDl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 11:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiCJQC4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 11:02:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D64D187BB7;
        Thu, 10 Mar 2022 08:01:21 -0800 (PST)
Received: from zn.tnic (p200300ea971938780dcf83143dcfc403.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:dcf:8314:3dcf:c403])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0ED11EC0674;
        Thu, 10 Mar 2022 17:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646928075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qq1ByKEPBSOo/sxIVvH/rIkfLgpjba3Yntjh1xdYd/I=;
        b=iRMmjX8EophVuPbvrtk5pc6091UVZXSKZ3ayEvHjTthXbp47gR22KcjFqM+ysNLjmFBU+j
        am2ESH4Ma51vPykRGvii5uoE2WZfDDPQi0Dank5eqbP4Dr8AvT/bxN6mHzhSfnAmAl5NwN
        IL4LvDdaqJaufeWucHZmzp0kuB413Lw=
Date:   Thu, 10 Mar 2022 17:01:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 07/24] EDAC/amd64: Define function to dehash address
Message-ID: <Yiog0a3FnZvV6oSh@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-8-yazen.ghannam@amd.com>
 <Ygbng0RZ0Pu1fOFj@zn.tnic>
 <YikhDoGD+V7OdBq4@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YikhDoGD+V7OdBq4@yaz-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 09, 2022 at 09:50:06PM +0000, Yazen Ghannam wrote:
> But I can do something like you suggest. There will be an unconditional call
> to dehash_addr(). Helper functions will be called for specific interleave
> modes. Otherwise, it'll return 0 if hashing isn't used.

That sounds like proper design to me. A single function which dehashes
an address and that's the only thing it does but it takes care of all
possible cases.

Yap. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
