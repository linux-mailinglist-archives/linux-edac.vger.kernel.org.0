Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D977726F682
	for <lists+linux-edac@lfdr.de>; Fri, 18 Sep 2020 09:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRHMh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Sep 2020 03:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRHMg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Sep 2020 03:12:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944CBC06174A;
        Fri, 18 Sep 2020 00:12:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c2600a65c515d56d1ce56.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2600:a65c:515d:56d1:ce56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 011451EC027A;
        Fri, 18 Sep 2020 09:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600413155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iHhrIzMeq+aky6lIVbBEUoaSgS50cLMuKK4BEhmeBR0=;
        b=Vhyv3nuwlfSPig8HX0b/WRfrutaXNI4//og2ZTkvD6TrOyB3dSdw41SaRfLXyxXMXy+JYH
        3ujobSFWDCCvbzsYU9alzOwQO+kxYeAH/Egpowk7vjT+ofPLrIdDE/opxws7DG3ooffwu+
        rUE8d9aKTDDZUdxFjiwEudiBVxLaI5U=
Date:   Fri, 18 Sep 2020 09:12:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/mc_sysfs: Add missing newlines when printing
 {max,dimm}_location
Message-ID: <20200918071227.GA6585@zn.tnic>
References: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200916170052.GO2643@zn.tnic>
 <591e613e-0b53-028f-08fd-3d62a35b8c4f@huawei.com>
 <20200917162537.GL31960@zn.tnic>
 <8ac6d481-e1c4-108e-dbec-b1e86b2d0e86@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ac6d481-e1c4-108e-dbec-b1e86b2d0e86@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 18, 2020 at 10:37:28AM +0800, Xiongfeng Wang wrote:
> Thansk a lot. I will send another version. Also I will change the
> 'snprintf' in 'dimmdev_location_show()' to 'scnprintf'

No need to send another one - I have everything locally and just amended
it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
