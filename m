Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7D31BB082
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 23:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgD0Vb3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 17:31:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39105 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgD0Vb3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Apr 2020 17:31:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so28923006otf.6;
        Mon, 27 Apr 2020 14:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P3/VvZUA9zwno+73vZLI4qG6D4JXKfA1s3Po7FwNPGs=;
        b=owhqWAXN1Rwn8UT5PiawvSvU2OPzhL87Vis3K3cchKghfPJzUm5yA2f8CJVOwqNH9o
         J6zkpAwTyTpfMykOYJak8JDrNfonVd/tzCXWrAicY23IfYttzeU0pPu64hvJ3dlgc6OT
         GSu7E917hR7rA/xvbp1fXyI51oKfzZjUEw0xMUV1oGxI1TxRi3AMe/AeUgKuyCxQX7fP
         AV5VWpHAtoQQOEyegIzkhjPirnfprJ2FNLOG+rN1Kaug9aT0Hr6gRe+MxaV9rNiWNz9n
         f0caf8hnuj5rVQjdgOhRT4Dv/g13UB+d0g+Nspl17s1wZKX4Z0wEDXQ0uYKUfAH8706b
         ZOjA==
X-Gm-Message-State: AGi0PuY44Y1zIMS2X3LkR8i0zcRVGqhuVqoMbA7GkERPZ1e65YGvqOgq
        8QyTMXRPo2R5ygstnymbpA==
X-Google-Smtp-Source: APiQypLNeTWAxwwOfxU2MVkwYzjoiYWvXpMeZLwojCWXww6d2kmG4sLN+TM4J4N77uDJJPoW1+5EMQ==
X-Received: by 2002:aca:3a83:: with SMTP id h125mr598693oia.64.1588023088290;
        Mon, 27 Apr 2020 14:31:28 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p13sm4374770oom.34.2020.04.27.14.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:31:27 -0700 (PDT)
Received: (nullmailer pid 30448 invoked by uid 1000);
        Mon, 27 Apr 2020 21:31:26 -0000
Date:   Mon, 27 Apr 2020 16:31:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: edac: Add cadence ddr mc support
Message-ID: <20200427213126.GA26416@bogus>
References: <20200424083155.30918-1-dkangude@cadence.com>
 <20200424083155.30918-2-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424083155.30918-2-dkangude@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 24 Apr 2020 10:31:54 +0200, Dhananjay Kangude wrote:
> Add documentation for cadence ddr memory controller EDAC DTS bindings
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> ---
>  .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   45 ++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml: properties:compatible:items: ['cdns,ddr4-mc-edac'] is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml: properties:compatible:items: ['cdns,ddr4-mc-edac'] is not of type 'object', 'boolean'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml: properties:compatible:items:0: 'cdns,ddr4-mc-edac' is not of type 'object', 'boolean'

Documentation/devicetree/bindings/Makefile:11: recipe for target 'Documentation/devicetree/bindings/edac/cdns,ddr-edac.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/edac/cdns,ddr-edac.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
warning: no schema found in file: Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml: ignoring, error in schema: properties: compatible: items
warning: no schema found in file: Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml: ignoring, error in schema: properties: compatible: items
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1276250

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
