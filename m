Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0652513CDED
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 21:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAOUQk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 15:16:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36540 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgAOUQk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 15 Jan 2020 15:16:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so16713564oic.3
        for <linux-edac@vger.kernel.org>; Wed, 15 Jan 2020 12:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=1BVQS3/CT2AwFowBzdJp24DkQzhe3BERjAeXkX0Uz7k=;
        b=tKXULh+8jHLq3zLWaR9SgwhxiaVR0XUg4s0I/7jAcU+5QgTjwht43pFly2mCAI3uJL
         1ZKJCKdDKp9KT95batv+XV27n0cyHCL0dcnDo3Jy7iYq4VyMm0Y18i0W4jz0AmVzvBZS
         y0MI36rMO38j9mTS+3vV9XxRzeOXFSmibHhyJkgRipzCjdWP1JUmcHwTK0UXI6h8HNaY
         ONHxYEf3mg201f5acjOvMv+quki0NLcGAVBGtM4iV0Rlo6eCnYCLvHPwC6qLfKUZEkoj
         QaecGvd5bFwWaDm/FEkSuSawJlwrteWvbJ/r11PWE1UCDtsPQwX2rugD89963snT0c6A
         lxTw==
X-Gm-Message-State: APjAAAVE2ArdEdQOSbXEP0Smc5U7iopstVg7rIL/C9INR1zActNpDEwQ
        T4JAaFyUmJAAT0vTBU+jGXNADhw=
X-Google-Smtp-Source: APXvYqyVIfiewznMeM86rveHWiNg0uFb1FOriqjQDcy0vAKU4gxVjmG2gZreMKh/gfadxPLueV0sRA==
X-Received: by 2002:aca:5f87:: with SMTP id t129mr1345223oib.36.1579119399345;
        Wed, 15 Jan 2020 12:16:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r25sm6906821otk.2.2020.01.15.12.16.37
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:16:38 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 14:16:37 -0600
Date:   Wed, 15 Jan 2020 14:16:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
Subject: Re: [PATCH v9 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <20200115201637.GA25883@bogus>
References: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 15 Jan 2020 06:32:27 -0800, Shiping Ji wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>      Changes in v9:
>          - Replaced the vendor specific interrupt-config property with interrupt-names
> 
> ---
>  .../devicetree/bindings/edac/arm-dmc520.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
