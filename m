Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5D228970
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 21:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390942AbfEWThS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 15:37:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60898 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391147AbfEWThR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 15:37:17 -0400
Received: from cz.tnic (unknown [165.204.77.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E585E1EC0249;
        Thu, 23 May 2019 21:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558640236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Srz9nZ3KqeuWjClvOk7zYv9LY9g9nrm5xPcxGRQlFLg=;
        b=pL5nUok9ZIay72KrYyGu3TZDURNZJG33dgbozo1hyAIUyqg6Y3SWsQh7nNXVWl5bJ4vgpY
        BP9wTC+Egqml/s8YdFAX6WJGzTlvOX8ou5mUBqZ7DAOuwDq15ds6hguSrlEeQZhMhoH05f
        Ga1LyEvyIpKw4c0SSEb7xwSitV5/O+A=
Date:   Thu, 23 May 2019 23:37:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/MCE: Statically allocate mce_banks_array
Message-ID: <20190523213704.GB3980@cz.tnic>
References: <20190523150345.42906-1-Yazen.Ghannam@amd.com>
 <20190523202754.GA3980@cz.tnic>
 <SN6PR12MB2639AAC20E9F01D1DE810E17F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639AAC20E9F01D1DE810E17F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 23, 2019 at 07:23:08PM +0000, Ghannam, Yazen wrote:
> Sure, but which patch are you referring to?
> 
> This seems to fix a patch in the set in bp/rc0+3-ras.

Sorry, I got confused. So bp/rc0+3-ras is not cast in stone - feel free
to take it and merge this change into 5b0883f5c7be ("x86/MCE: Make
mce_banks a per-CPU array") and then fix up any potential conflicts
coming from the following patches. And then send the whole pile as a new
revision.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
