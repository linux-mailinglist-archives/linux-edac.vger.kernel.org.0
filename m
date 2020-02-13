Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9615BE68
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2020 13:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgBMM2U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Feb 2020 07:28:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34962 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgBMM2U (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Feb 2020 07:28:20 -0500
Received: from zn.tnic (p200300EC2F07F600746843EFEB191E44.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f600:7468:43ef:eb19:1e44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0FA31EC0CE8;
        Thu, 13 Feb 2020 13:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581596898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y6KTfW5zJPWE+4QNsDGMdjC0n5CEoWJZz2FyoidawUo=;
        b=ktjK/JVE8Th9l4RA96YkbGJl4OIvDM2fOaqXcKjlmR/8/h5wLPxL0n4As3Lv5Y+OzTxMyb
        c+6WjDFIhDeqzTqBuNopv3NYbBDq0ku3CjVXP9CqULGhqjApLrGEmWTKR/AXTbikuyz2mn
        Aqv3BoDDDuoI6Hs1cQiu+0xtONvZz30=
Date:   Thu, 13 Feb 2020 13:28:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] EDAC/mc: Fixes for mci device removal
Message-ID: <20200213122808.GI31799@zn.tnic>
References: <20200212120340.4764-1-rrichter@marvell.com>
 <20200213110512.GH31799@zn.tnic>
 <6617867c-f9e1-b7b8-d605-d273b8dd7f69@huawei.com>
 <3b120ae3-eeef-7509-84b1-d679f0e3f783@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b120ae3-eeef-7509-84b1-d679f0e3f783@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 13, 2020 at 12:08:59PM +0000, John Garry wrote:
> Yeah, it looks ok - I'm just booting and running a kmemleak scan

Thanks, I'll add your Tested-by:

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
