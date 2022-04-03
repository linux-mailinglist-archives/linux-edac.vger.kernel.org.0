Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3E4F0C88
	for <lists+linux-edac@lfdr.de>; Sun,  3 Apr 2022 22:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbiDCUq1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 Apr 2022 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDCUq1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 Apr 2022 16:46:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0515A21;
        Sun,  3 Apr 2022 13:44:32 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BA211EC03C9;
        Sun,  3 Apr 2022 22:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649018667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R2DzlzIYSzHF0dRvT07sgtvtW6pe94L8S4uMeJ5kYDY=;
        b=fIzA/QH0T7ebh01oPmMET4Qd935FH80CfxvrZ0jFXQObL8mMpbSxgBH36I6C/Wo0IZDubo
        H/h4enaBSy+myGOCV0ceDBhf21WaXY2blBxj6zQ3Bz1kooiH+tUjYuGzn8OXMrpEB6DooA
        grYz37cA8QeKXDZH20uAeNH5DVhljGw=
Date:   Sun, 3 Apr 2022 22:44:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 2/3] x86/mce: Define function to extract ErrorAddr
 from MCA_ADDR
Message-ID: <YkoHKTuGaFfsF6qb@zn.tnic>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
 <YkWrlTIK/ZxsQekX@zn.tnic>
 <YkmeJFXXbu3aLzzw@zn.tnic>
 <Yknsbp+zMh8Uev8+@zn.tnic>
 <87mth2kkhc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mth2kkhc.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Apr 03, 2022 at 09:58:07PM +0200, Thomas Gleixner wrote:
> How is __always_inline supposed to work across compilation units w/o
> LTO? The callsite is in core.c ...

Hmm, right.

So even with patch 3 adding more changes to that function I think it is
still simple enough so that we can move it up into the mce/internal.h
header so that the inlining can work.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
