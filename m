Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFB28E13D
	for <lists+linux-edac@lfdr.de>; Wed, 14 Oct 2020 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgJNNZm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Oct 2020 09:25:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35653 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgJNNZj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Oct 2020 09:25:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id w141so3221842oia.2;
        Wed, 14 Oct 2020 06:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rvR8s/WlucdjZmeBMSsyING5az8VS9CvfEYp9YQmlNI=;
        b=h2WvGZURWllYld5WAOf8ozvyCL7hZjiIaR9guovGk0Q+mTzmKPHC3mNmJ7706PisVd
         98mvC42pwr6pD5aWnNzl1oNH4b+qU+5sQ/WqB+vTfxMf/nHzkFuZCVg9WpULyxU2yWhp
         Xaam+zNoNPy/uzGCcRZk8c3KPLVdLNnFX3FB0xyUTXq6N9x+t+y96qy8vvz5aUkAkWQA
         SGsqoEmS2yd3U6m6WYbud/r3iOwdIocl+oWNNGkM864R+HvYAMfD6/STqqrukXgZh0Ch
         SsWcEa/yEF8Xhu8nT6YLYW+1Nigb3panVnChF2kp8PS4gikeV+YMCIAzZclz961L6s3e
         ubYg==
X-Gm-Message-State: AOAM532A34I5EBqp58we+VxHMHr7AmPTEV9BkbrMLJuwZJuS6e22VDNI
        QhafnjyLfThyit1t623G3g==
X-Google-Smtp-Source: ABdhPJxurnyLs/+bkhN/mfwIYxRCK0ONC6kwXfXvRalt2JyOoX/7UzdQIi5szGfNcXcAZ1wrLJF0QQ==
X-Received: by 2002:aca:560a:: with SMTP id k10mr255528oib.27.1602681937838;
        Wed, 14 Oct 2020 06:25:37 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m1sm1203177otq.30.2020.10.14.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:25:37 -0700 (PDT)
Received: (nullmailer pid 1535285 invoked by uid 1000);
        Wed, 14 Oct 2020 13:25:36 -0000
Date:   Wed, 14 Oct 2020 08:25:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, York Sun <york.sun@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/3] dt-bindings: edac: Add binding for L1/L2 error
 detection for Cortex A53/57
Message-ID: <20201014132536.GA1535030@bogus>
References: <20201013125033.4749-1-s.hauer@pengutronix.de>
 <20201013125033.4749-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013125033.4749-2-s.hauer@pengutronix.de>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 13 Oct 2020 14:50:31 +0200, Sascha Hauer wrote:
> The ARM Cortex-A53 and A57 CPUs support error detection for the L1/L2
> caches. This patch adds a binding for the corresponding driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/edac/arm,cortex-a5x-edac.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml: 'maintainers' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml


See https://patchwork.ozlabs.org/patch/1381567

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

