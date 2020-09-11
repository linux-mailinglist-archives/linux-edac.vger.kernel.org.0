Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594DA265E82
	for <lists+linux-edac@lfdr.de>; Fri, 11 Sep 2020 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKLGx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Sep 2020 07:06:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49280 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKLGw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Sep 2020 07:06:52 -0400
Received: from zn.tnic (p200300ec2f0ce000fc39479f3b37cbf3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e000:fc39:479f:3b37:cbf3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A77F1EC050F;
        Fri, 11 Sep 2020 13:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599822411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FmQIYnrc2hwilIfPoogJbnGbFEsJDR+JvWYLvbwl8t8=;
        b=nkb0qvhj+tDyB3jA40UUlu0tHinMKz3lVH80aLb4mADu1cHCmD16wIjcLuBfuJRx37ayKF
        21HkFJSeKMKsvrR6SPEJlV3D3HwlCJa9Cg3cKN2L75iUOyJuHt6j1IygFd+Lz2hJOko/JQ
        5kb3T9vSePAfypBjVVCucSxmZg403iQ=
Date:   Fri, 11 Sep 2020 13:06:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     "york.sun@nxp.com" <york.sun@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: (EXT) Re: [PATCH v2 1/1] edac: fsl_ddr_edac: fix expected data
 message
Message-ID: <20200911110646.GA8472@zn.tnic>
References: <kcEE.e0qfoTd8SOOr3lTVWaXz/A.AASg8YeC1gE@vtuxmail01.tq-net.de>
 <20200904091718.GC21499@zn.tnic>
 <20200904133258.GA21716@herburgerg-w.tq-net.de>
 <20200908192400.GL25236@zn.tnic>
 <20200910150628.GA26249@herburgerg-w.tq-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910150628.GA26249@herburgerg-w.tq-net.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 10, 2020 at 05:06:28PM +0200, Gregor Herburger wrote:
> 

Dunno if you were trying to say something but this mail is empty:

Content-Length: 1
Lines: 1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
