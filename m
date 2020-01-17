Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2271140DC7
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAQPZy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Jan 2020 10:25:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42042 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgAQPZy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 Jan 2020 10:25:54 -0500
Received: from zn.tnic (p200300EC2F08DC00788A88DBA2D0C692.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:dc00:788a:88db:a2d0:c692])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FD691EC0C51;
        Fri, 17 Jan 2020 16:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579274752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NXDhbVMip1oFNmzSwPSlff9/2JLjF0uDNe9CeQPatZc=;
        b=ivNXuSuHY1SkuCb0ORK4thJwvkiYn6GhKmdoGgv9Z6AiOlg65O40XEC1EKW07R/A2oE8hR
        DU+cJpikec3G9aTJ6U7yzzEthR6TTnHA3hGaukdMm0ZysqnoW1IDPhkAHRQVos/MsxUwQt
        6pVStWucOKzBjM/wmC2oVXt1RmuxiiY=
Date:   Fri, 17 Jan 2020 16:25:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/5] x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit
 McaType
Message-ID: <20200117152544.GA31472@zn.tnic>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
 <20200110015651.14887-2-Yazen.Ghannam@amd.com>
 <20200116155116.GE27148@zn.tnic>
 <BN6PR12MB166790FFA9876C17E6C4D351F8310@BN6PR12MB1667.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR12MB166790FFA9876C17E6C4D351F8310@BN6PR12MB1667.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 17, 2020 at 03:14:06PM +0000, Ghannam, Yazen wrote:
> [AMD Official Use Only - Internal Distribution Only]

...

> Yes, you "may" be right. :)

:-)

> Seriously though, I'll work on it. Thanks!

Thanks.

Also, you might wanna work on that piece of crap at the beginning of the
mail too:

> [AMD Official Use Only - Internal Distribution Only]

I don't think there's a problem to use another mail provider but keep
your SOB and From: mail for authorship attribution.

Company mail setup is simply inadequate for upstream development. It
almost doesn't matter which company. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
