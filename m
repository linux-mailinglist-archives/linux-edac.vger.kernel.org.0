Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC7C1315F7
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2020 17:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAFQXL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Jan 2020 11:23:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49558 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgAFQXL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 6 Jan 2020 11:23:11 -0500
Received: from zn.tnic (p200300EC2F270F00B18FEB7C8E4C4E0C.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:f00:b18f:eb7c:8e4c:4e0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 048751EC0C51;
        Mon,  6 Jan 2020 17:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578327790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=onIFPPp72p79GQGtGWOAdjGSjX1w4haOX51Ul041Juo=;
        b=Mz7JFffHz6pqDN3QGTzI1Hf4s+YUQUlCGVk4xI/hjJ2LohaWyPpEgXqO2VUQCbKr87TDhZ
        bAKIt3it+vE4+Mc32U28e4oG0kX0BWUingl4tFrazP1ZEvxKGBwIpGKq2+1+rc9PeNcFWi
        5HUCnZTJxBcWGFqx3uhfkP0c479NMpo=
Date:   Mon, 6 Jan 2020 17:23:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     'Aristeu Rozanski' <aris@redhat.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20200106162306.GG12238@zn.tnic>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
 <20191210090013.GA9395@zn.tnic>
 <20200106151242.vkdiiwhubmkx5osh@redhat.com>
 <20200106161732.GF12238@zn.tnic>
 <20200106162013.cbbeo4ezdp2h7p62@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106162013.cbbeo4ezdp2h7p62@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 06, 2020 at 11:20:14AM -0500, 'Aristeu Rozanski' wrote:
> OK, will resubmit this patch just removing the messages then.

I'm not saying you should blindly remove them. They might be useful for
debugging purposes so you should consider that usage angle first. In the
AMD case, the message was really useless.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
