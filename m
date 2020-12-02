Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF52CC047
	for <lists+linux-edac@lfdr.de>; Wed,  2 Dec 2020 16:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgLBPDz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Dec 2020 10:03:55 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58737 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgLBPDz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Dec 2020 10:03:55 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4DF59580132;
        Wed,  2 Dec 2020 10:03:09 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 02 Dec 2020 10:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=zKHBXpuw+WPRxYjKCr+NVoOy6HmLEmi
        pUWxQdocXY44=; b=inplWYyfQJqds7vglOwm5zUoQr2WvvTwZ81yB/6SWEAfzt4
        yyfNOxpkuC8Gho2V8At4KOUsKV3LESaha0MQQa5dEm/UcT8ailj9ZNY1kPCaOqaj
        Fh37aCFHPOB2pQLhVcqXD1X4d2oXJ7CXjuGzkIQ0Gwdta0ytwJhsWIh/HTxom0Bt
        gCC1QVNvKEpMU/OTL2tA5qQCoqZvePhEG3pcEiaJ3vNXM2Sa6tyQmH9sPDfSFHmp
        V68iVy14EvlkSFiaLVadcaCdfX1C7uyEpvqTCx9Qy6iu4WpY330rdErGufQInr6t
        +S58OJd4UF3qpt6GZ0d11EIikMwcf6BQjEDQTGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zKHBXp
        uw+WPRxYjKCr+NVoOy6HmLEmipUWxQdocXY44=; b=Fq+VbBkybpikgWgp2qOWLZ
        gYejKwOvXLsdF7H0+DdyZb2/oH2bgEK+1ZzGR7Tb+GQgL0jsCi7+t7pjRP2pJlPe
        ooCgBttACOiSMU/fU7NiM5Ou55eQWXS2rDK+4ygx7JWnsCEWdaL2EQzSA5l72hms
        tbfyX6Mmu+WiZhlQz+ERKFiK9vqoMEt1sMXlx3aS3OzLyG2B3BDfP5v/AKLystW6
        Ppr1jmNbSzq3Qpra9VEfIT/xRZ0vGIvnAzc5WCbc6v0OnTzRLJRdN+a195mWDCD9
        sGt0hwaRdNhj2jdUDF9RzRsknSrL4fTk0QgJfk0LbH/qaAIYHiVunifURA/zVhRQ
        ==
X-ME-Sender: <xms:qqzHX1lcbG5TkCi8uQk1gkT7pXtoVu_8oYLi2EPrMRkYEia26nfdnw>
    <xme:qqzHXw1kHffEpb5fby9_o_FjulyaLKPOknZcqXqJL0b2Af3JHsCZp3JfH-71skvDQ
    RNjs7DGbUHSCSJiZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeigedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:qqzHX7qfwxhOYMJQNx5SUJDRbo2oMhBVBlkU63XiUu39paomza-F9A>
    <xmx:qqzHX1mKJx3F9u2t9pFvDHWt4oW19eJkxuQEOKTMtZXSKUavxcfovA>
    <xmx:qqzHXz2iceQ461WQJ4IKjsMPsrXx9Ku41EdyJRDEXIR_wsGyChPV_g>
    <xmx:razHX60C_AWcQXD-jkuSWLjePszNYKpAS5RXWOb-XFIy1tz3DcViaQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CD5CE00D4; Wed,  2 Dec 2020 10:03:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <b6dd3a91-abe7-4e9d-b801-6e54e4c88827@www.fastmail.com>
In-Reply-To: <PS1PR06MB26008E4BCB805553EDEC45038AF30@PS1PR06MB2600.apcprd06.prod.outlook.com>
References: <20201202063612.21241-1-troy_lee@aspeedtech.com>
 <20201202063612.21241-3-troy_lee@aspeedtech.com>
 <CACPK8XcBTm8-cAPmtswHbYAf2B+PdBiZ2s1XK1UqKA_NQX_-mw@mail.gmail.com>
 <PS1PR06MB26008E4BCB805553EDEC45038AF30@PS1PR06MB2600.apcprd06.prod.outlook.com>
Date:   Thu, 03 Dec 2020 01:32:44 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Troy Lee" <troy_lee@aspeedtech.com>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "James Morse" <james.morse@arm.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Robert Richter" <rrichter@marvell.com>,
        "leetroy@gmail.com" <leetroy@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Stefan M Schaeckeler" <sschaeck@cisco.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Wed, 2 Dec 2020, at 19:11, Troy Lee wrote:
> Hi Joel,
> 
> Thanks for the suggestion, I'll fix the review and create an new patch 
> against 
> latest Linux branch. Those exported function will be referenced in 
> other driver yet 
> to be upstream, so should I move those exported functions out of this 
> patch?
> 

Yes, let's leave the exports out of this patch, and add them in when you send 
the patch that depends on them.

Andrew
