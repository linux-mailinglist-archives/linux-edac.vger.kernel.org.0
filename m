Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE201800E
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2019 20:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEHSuS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 May 2019 14:50:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41652 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHSuS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 May 2019 14:50:18 -0400
Received: from zn.tnic (p200300EC2F0F5800C5ADF1C39910BD59.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5800:c5ad:f1c3:9910:bd59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F1C61EC0235;
        Wed,  8 May 2019 20:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557341417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hmUZn3xegPKbeKM49ymYgt6RrEMncxgci4HJk+S/yic=;
        b=nEg6COYvY0pLSQLlOSybiKiYfzc+YwwXngwo6C/2enUwRcBSxnntsYogNtqyj8e2rTu/iS
        Fs827fkeO4DDvDM/cI/3/PXQ4sTowOG+5iCHZyZ2pjCwlCeXTkrweMBmRwwJJpiEdLUO5Q
        ZOCzs1/zoFaall43ABAlfqUrr6xQJNA=
Date:   Wed, 8 May 2019 20:50:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     PanBian <bianpan2016@163.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: EDAC: Fix memory leak in creating CSROW object
Message-ID: <20190508185007.GH19015@zn.tnic>
References: <1555554438-103953-1-git-send-email-bianpan2016@163.com>
 <20190418172548.GL27160@zn.tnic>
 <20190419003536.GA57795@bianpan2016@163.com>
 <20190419004516.GC559@zn.tnic>
 <20190427214925.GE16338@kroah.com>
 <20190508105743.GC19015@zn.tnic>
 <20190508124754.GD8646@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508124754.GD8646@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 08, 2019 at 02:47:54PM +0200, Greg KH wrote:
> Looks good to me, ship it!

Thx, done!

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
