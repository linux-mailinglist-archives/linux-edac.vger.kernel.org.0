Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7469C1A44BC
	for <lists+linux-edac@lfdr.de>; Fri, 10 Apr 2020 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDJJwJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Apr 2020 05:52:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgDJJwJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 Apr 2020 05:52:09 -0400
Received: from zn.tnic (p200300EC2F0CB7007559D7B1A4FC9407.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:b700:7559:d7b1:a4fc:9407])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FF791EC0CF2;
        Fri, 10 Apr 2020 11:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586512328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WQuZtTSg9+0XoEeNCCeYTfWr/6/2aZzT/q4rHTrDrUg=;
        b=iDl6k1YusnWxVkjJj16BFkPkqYl+cpCd+SgWQ4sN5VuLyE7F9c5SGWQGxRSdyOPKHBRBCm
        QpO2Mjv05s0hkx2lAg0bEV2tJafvnEV7LQXhxEp28DhvyMEcptpjXJjuExeAwj+WS6gyRc
        GZ31CKOMAgaNKgA1mXvbMbhKSV6UYR0=
Date:   Fri, 10 Apr 2020 11:52:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     rrichter <rrichter@marvell.com>,
        "thor.thayer" <thor.thayer@linux.intel.com>,
        mchehab <mchehab@kernel.org>, "tony.luck" <tony.luck@intel.com>,
        "james.morse" <james.morse@arm.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/altera:Use platform_get_irq_optional()
Message-ID: <20200410095206.GA8205@zn.tnic>
References: <20200402112740.15580-1-tangbin@cmss.chinamobile.com>
 <20200402123001.obgzqmlure4cfvh7@rric.localdomain>
 <202004022106312118022@cmss.chinamobile.com>
 <20200408071022.ft6aamptrxlaz23f@rric.localdomain>
 <2020040819334451781313@cmss.chinamobile.com>
 <20200408113658.GE24663@zn.tnic>
 <1b9a872f-f616-8eaf-1cca-d73647f696e3@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b9a872f-f616-8eaf-1cca-d73647f696e3@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Apr 10, 2020 at 04:25:24PM +0800, Tang Bin wrote:
> I am sorry for the previous writing mistake(top-post). I have consulted
> others and hope it's right this time. Sorry again and thanks for teaching. I
> hope to continuously improve myself and regulate myself under your guidance.

That looks better, thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
