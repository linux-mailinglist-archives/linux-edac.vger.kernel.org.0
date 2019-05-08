Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319BE175C3
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2019 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEHKO5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 May 2019 06:14:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfEHKO4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 May 2019 06:14:56 -0400
Received: from zn.tnic (p2E584D41.dip0.t-ipconnect.de [46.88.77.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 622261EC0C09;
        Wed,  8 May 2019 12:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557310495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nDsb/D73KVuZC2JEvukNpVi8yfND5pnCi4MhFeu3w9c=;
        b=GNZIZ9vrkwqDLVxRo0e3vaEBIsNEYR/xdf+xzTDNS2rSIXPwdB0FWGmCV/lBzj5dzPWJlQ
        ThlAyVGSydiBicE0pj31VTe+w7qzc1LlOS1IRrlQJ6M1fKIc1dxUhX9WD/QRTk3uNUdEi4
        IPGOh3xMDCx6Edg9YeAZosv7FZ9UeZ0=
Date:   Wed, 8 May 2019 12:12:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Johannes Thumshirn <morbidrsa@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, linux-edac@vger.kernel.org,
        mchehab@kernel.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
Message-ID: <20190508101238.GB19015@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au>
 <20190506065045.GA3901@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506065045.GA3901@x250>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 06, 2019 at 08:50:45AM +0200, Johannes Thumshirn wrote:
> Acked-by: Johannes Thumshirn <jth@kernel.org>

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
