Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC19B384
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2019 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfHWPhs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Aug 2019 11:37:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfHWPhs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 23 Aug 2019 11:37:48 -0400
Received: from zn.tnic (p200300EC2F0BC5003C7EECCB3B09C289.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c500:3c7e:eccb:3b09:c289])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AEF401EC0ABC;
        Fri, 23 Aug 2019 17:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566574662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tPd7cxcXtF6Z+Vts+kIedJB73gp3fadMQe5eBBiTFdE=;
        b=B0eLQoA+9WuNOnW3WSnHEDtLu1fHqrDJNPmfsJfcOO5HhfuCMTgmMMhovAKvsgDageJFo9
        L+gT/Gt/KchCGxZ+paP00XbphVe/1DT2RwOibkTuSQ+NKyx+GkUaSom9RTnS4KLBQHJvpJ
        0Ce3QfPiezSDLesZQHnf3te02Tn8TuU=
Date:   Fri, 23 Aug 2019 17:37:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] AMD64 EDAC fixes
Message-ID: <20190823153739.GC28379@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
 <SN6PR12MB2639CD6D755B6FFCF5C4B756F8A50@SN6PR12MB2639.namprd12.prod.outlook.com>
 <SN6PR12MB263989CCDCC0F74138B6B747F8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263989CCDCC0F74138B6B747F8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 23, 2019 at 03:28:59PM +0000, Ghannam, Yazen wrote:
> Boris, Do you think it'd be appropriate to change the return values
> for some cases?
>
> For example, ECC disabled is a hardware configuration. This doesn't
> mean that the module failed any operations in this case.
>
> In other words, the module checks for a feature. If the feature is not
> present, then return without failure (and maybe give a message).

That makes sense but AFAICT if probe_one_instance() sees that ECC is not
enabled, it returns 0.

The "if (!edac_has_mcs())" check later is to verify that at least once
instance was loaded successfully and, if not, then return an error.

So where does it return failure?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
