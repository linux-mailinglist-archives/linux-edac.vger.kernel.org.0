Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E1B146EE2
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 18:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgAWRAS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 12:00:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37460 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbgAWRAR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 12:00:17 -0500
Received: from zn.tnic (p200300EC2F095B000C549FEBFD6AD70E.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:c54:9feb:fd6a:d70e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3EC101EC0591;
        Thu, 23 Jan 2020 18:00:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579798816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2Zi/Vu+B2l9NFcgdnSTKPUukaPhmaLbQ1nWfcYAwaa4=;
        b=kAooszeV1IOJNNYaiYaFa7CrqxTrhAV64Bm/c8m0EExBkSNPh9YuDLtWDwS3jXtGUYWZYh
        +jSE5jpUrk7DVGMWExLkb10lYo9nYOLiKvE9iA72iY9wS54Lv1I9Xumyap9BOxK0voKTDv
        Vn8erO2TERKmT88Dj/mhGcLAijtaAiM=
Date:   Thu, 23 Jan 2020 18:00:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: edac: dmc-520.yaml
Message-ID: <20200123170014.GF10328@zn.tnic>
References: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
 <20200123082322.GB10328@zn.tnic>
 <4165bb52-6dda-60e9-c248-428822167476@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4165bb52-6dda-60e9-c248-428822167476@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 23, 2020 at 08:47:31AM -0800, Shiping Ji wrote:
> Boris, we'd still like to keep her as the author since this patch is
> just updating to a new documentation format where the content being
> documented was still designed by Lei. I hope this is OK.

Ok, fair enough.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
