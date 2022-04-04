Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF684F1DBD
	for <lists+linux-edac@lfdr.de>; Mon,  4 Apr 2022 23:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377343AbiDDVlG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 Apr 2022 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379969AbiDDS36 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 Apr 2022 14:29:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8DF13F48
        for <linux-edac@vger.kernel.org>; Mon,  4 Apr 2022 11:28:02 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A26571EC04AD;
        Mon,  4 Apr 2022 20:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649096876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AMjg64zvttz4PpmcUaJSmy99PcWWyDR1ehheufMZ5OU=;
        b=qwDEi4IYTS0HXhWoSN3iemIHsyGNYdZzKtex8/J0W0PvfN/ulgxTuGVuERf81962xG9ea5
        vS/rPyVxGb54dQrIla3FiC5QxEqCfKv9ofmpskRjCToNfwgnuGA8iHvHLX0/eM4AqgzLEX
        7apruiO7tvdKqjnQz7PoLF0HQe+edC0=
Date:   Mon, 4 Apr 2022 20:27:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 06/14] EDAC/amd64: Add get_mc_regs() into pvt->ops
Message-ID: <Yks4qoFN4X+3QmT4@zn.tnic>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-7-nchatrad@amd.com>
 <YkHdZ1UWh9o016j1@yaz-ubuntu>
 <4f7e4f58-41d4-f08b-56ff-e0f83c4bfed3@amd.com>
 <Yks2uNprjjQSO36/@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yks2uNprjjQSO36/@yaz-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 04, 2022 at 06:19:36PM +0000, Yazen Ghannam wrote:
> I'm not aware of any users of this. But this isn't a robust interface like an
> ABI.

Yes, kernel printk message formatting is not an ABI.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
