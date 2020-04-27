Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158451BAB62
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 19:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgD0ReM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 13:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgD0ReM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Apr 2020 13:34:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D126C0610D5;
        Mon, 27 Apr 2020 10:34:12 -0700 (PDT)
Received: from zn.tnic (p200300EC2F05F00014E720D2A42E8264.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f000:14e7:20d2:a42e:8264])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 992521EC0D0B;
        Mon, 27 Apr 2020 19:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588008850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ziGfCAfomKzl6PbHUax/kOvF/TnduRcl7QwWrxwzfCY=;
        b=ZsJGbYySCGqBaH2Iq10RNlZKMjcnEVOSyZeQvV1kIv2eqIhM26s8sfUKFUP6etZHj/xt2j
        qd9TsK37g3hYQiqjl1APvHcn+9dpoHgxkzo5OGcgMcBbUyd3SBES06GN8hez6eqSZsTphZ
        S3X/3G1965IG4kL2ipTJI53+NHdtOzQ=
Date:   Mon, 27 Apr 2020 19:34:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] EDAC/ghes: Remove local variable rdr_mask in
 ghes_edac_dmidecode()
Message-ID: <20200427173402.GH11036@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-7-rrichter@marvell.com>
 <20200427070802.GA11036@zn.tnic>
 <20200427172408.GA13177@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200427172408.GA13177@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 27, 2020 at 10:24:08AM -0700, Luck, Tony wrote:
> That isn't the same. The previous version checked that BOTH bits
> 7 and 13 were set. Your version checks for either bit.

Whoops, I'm confused again. ;-\

> Looks like the original with the local variable was checking for both
> bits set.

Yeah, let's leave it as it is. I prefer the rdr_mask thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
