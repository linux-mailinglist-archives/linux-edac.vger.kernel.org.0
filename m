Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA89B132B45
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2020 17:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgAGQpi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jan 2020 11:45:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56160 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgAGQpi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Jan 2020 11:45:38 -0500
Received: from zn.tnic (p200300EC2F0FB400396D31B560FFF95B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:b400:396d:31b5:60ff:f95b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4D961EC0CDB;
        Tue,  7 Jan 2020 17:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578415536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jufPnKecMHTAkKEECZqo+A1p5PoTP4eEup3vWRrA1es=;
        b=qwSxTPDnjdCW+h0iv6RHxfILKoLbzhc0BB31oSiOYInRNbKrNg+qmDpVWCnNrcqYg1hlDs
        E5n90AmBbypxc52nBlcXVE/Wp9EggnwJSGE9NwdrK9FKN9+mpT35FiQquIhGeiA1KWU+X+
        i5W62+FlSInbz34i/COo58IgVKdq2ic=
Date:   Tue, 7 Jan 2020 17:45:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     'Aristeu Rozanski' <aris@redhat.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20200107164528.GD29542@zn.tnic>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
 <20191210090013.GA9395@zn.tnic>
 <20200106151242.vkdiiwhubmkx5osh@redhat.com>
 <20200106161732.GF12238@zn.tnic>
 <20200106162013.cbbeo4ezdp2h7p62@redhat.com>
 <20200106162306.GG12238@zn.tnic>
 <20200107155109.6gphrtqb2a7q4unn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107155109.6gphrtqb2a7q4unn@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 07, 2020 at 10:51:09AM -0500, 'Aristeu Rozanski' wrote:
> On Mon, Jan 06, 2020 at 05:23:06PM +0100, Borislav Petkov wrote:
> > I'm not saying you should blindly remove them. They might be useful for
> > debugging purposes so you should consider that usage angle first. In the
> > AMD case, the message was really useless.
> 
> Ah, I thought you had an objection to this patch :)
> Do you mind considering it for inclusion?

That's Tony's call as he's maintaining the Intel side of EDAC.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
