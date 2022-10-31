Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4EA6133A5
	for <lists+linux-edac@lfdr.de>; Mon, 31 Oct 2022 11:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiJaKaj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Oct 2022 06:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiJaKaN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 Oct 2022 06:30:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA2DFE2;
        Mon, 31 Oct 2022 03:30:04 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cf329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cf:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A7BE1EC063F;
        Mon, 31 Oct 2022 11:30:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667212203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r/KCiLuuGp4/XWyS/bxFjJye9xU97AuL3CfHHJ01CDE=;
        b=JWxG9xthzYEPXdVe+UgNRzkGqxw7Pgkf6jAK+89IVZMir8CU70bxPyibmneHLCZsBWyoEO
        /16fGtqh+bC0IirWLBEAPjcpCBqDfbXoytxUQiIESTvkQiKHfBtZInatKEwxozvInHGOs6
        VD54CP8/tbI0TaKUDduDEI5Ky7RP6c4=
Date:   Mon, 31 Oct 2022 11:30:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Dump stack after certain machine checks
Message-ID: <Y1+jqyh8dAz6tsTr@zn.tnic>
References: <20220922195136.54575-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922195136.54575-1-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 22, 2022 at 12:51:34PM -0700, Tony Luck wrote:
> I've only updated the Intel severity calculation to use this new
> severity level. I'm not sure if AMD also has situations where this would
> be useful. If so, then mce_severity_amd() would need to be updated too
> to return different severity for IN_KERNEL and IN_KERNEL_RECOV cases.

I'd look into Yazen's direction for that...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
