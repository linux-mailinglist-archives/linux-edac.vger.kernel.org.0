Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 836BE99012
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 11:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfHVJ4A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Aug 2019 05:56:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53470 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732459AbfHVJ4A (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Aug 2019 05:56:00 -0400
Received: from zn.tnic (p200300EC2F0DB400192DF49715E793F0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:b400:192d:f497:15e7:93f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A80841EC0819;
        Thu, 22 Aug 2019 11:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566467758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8VeWpv2h+H0NzeKdjodPTrcJtIQ9N9F7wR1pWa15SXY=;
        b=jeYif56vB5EWS/KCP5ftkAsRS/F7tYvSGbqKAQLTkf24Pn08bv+adobZrRv/G0tQ2z1F+l
        oeljkyzfZPATnbp7nGwftmaTvy+M+7Gvax8qnnMi/RjMcVRxCTszv3G5GtEX+esunho7jL
        x586B0PC76oZE7e5fsXj4e2uNaKoN+4=
Date:   Thu, 22 Aug 2019 11:55:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] AMD64 EDAC fixes
Message-ID: <20190822095554.GC11646@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
 <20190822083548.GA11646@zn.tnic>
 <20190822094607.GA14667@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190822094607.GA14667@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 22, 2019 at 11:46:07AM +0200, Adam Borowski wrote:
> Yeah, some of messages are no longer emitted for memory-less nodes (NUMA 1
> and 3).  Your patch set also overhauls the messages.

Not my patchset - Yazen's.

> But, the amount of redundant messages I'm complaining about has actually
> increased:

He's working on that - that still needs some love.

Thanks for testing.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
