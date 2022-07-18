Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA057844A
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jul 2022 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiGRNu7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jul 2022 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiGRNu6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Jul 2022 09:50:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8B26AEF;
        Mon, 18 Jul 2022 06:50:57 -0700 (PDT)
Received: from zn.tnic (p200300ea972976d7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76d7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8FB81EC01D2;
        Mon, 18 Jul 2022 15:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658152250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Myws9jzNIvlu+C/HWGYwNJKA8xrY2FJWYccW1o6/lyA=;
        b=XWFbQ54gpo7N6e0h0/l8Qfx8aJHoYYvkXOUPVTYxI2mYq9BuGUWttQA7SgRU8RYKijisrA
        M2UlDRYDtBWMzUGPpKpJJ9V3owEoEjWs2liHebOxXP2Yi6mMgU3xv5HMJtQML7Ke2mzVzz
        VHRizApbDH6MNyJiA0Qz3pW8eBGi7BQ=
Date:   Mon, 18 Jul 2022 15:50:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <YtVlNrW58cFmksln@zn.tnic>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah>
 <YtUgb2Y/H/Wq9yIn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YtUgb2Y/H/Wq9yIn@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 18, 2022 at 10:57:19AM +0200, Borislav Petkov wrote:
> Lemme talk to rostedt.

Right, he says __dynamic_array(). Grep the tree for examples.

I'm thinking we can add a field called vendor_info or so, at the end of
the TP and then dump whatever fields we want there.

We can even slap a flag in front of the whole thing saying what the
vendor info type is. But we don't have to get ahead of ourselves and
keep it simple first.

How does that sound?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
