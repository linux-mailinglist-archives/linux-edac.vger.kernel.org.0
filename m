Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA34B7DD9A
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2019 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfHAORJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Aug 2019 10:17:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41121 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbfHAORI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Aug 2019 10:17:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so70567718wrm.8;
        Thu, 01 Aug 2019 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKF3166gvz5+E0AYlc4TPktG4r3p+wz5j7C+OwZ5mY8=;
        b=JtX6UHg+sGBahZBSiWFubFtOIUDyR0pQQs1DKZPQbdWIU4V764RqroT0+nHKYjhzvr
         tJRIdef0yjoCUTdzzKNG7PPKK4dVP49PyZh64NaBJ6nnI5w+/J7LECdxUZQpzMX8oS9+
         2j2o9/DnsG2zLMRGk9j/B/I74opfwsiGPyXRhNbggIeBhBDFK0q8sDiB5WblylkhfUIU
         ncvymhGmOUckvmUSGSXpEP7qDvVAPxgRzDlzlYgS2ylaaCrqv+yM3AtiI8thYTiRmUGl
         H+lwZGRH0lFqztBPdL1pk2bn5AtBPsIwd/Ot4+06av3Pt/BPsUiESbuAgbO3oUIh4B3x
         /glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKF3166gvz5+E0AYlc4TPktG4r3p+wz5j7C+OwZ5mY8=;
        b=WRLqhMrqNIjpXdOaa/jCg7ZnaR7HngLeQraOP7FGdYnS2femuhvATJgkZ7GmTYJlw4
         PbnGFI4R/yMoyrTI1I8IAiT64I+pp0DeSQw8MRpr4F+QfixKHWJyqcfSDcVkBYJYsyZT
         NteME+c4zlN1x4SqOIAl1gQMPyaJ00sh0spkOMoIbOA2VSFwcKPBZUruCAQm+xooUrwr
         XdJyrYoTQ6qmhMwAxEADn0QL+g+GaVGC/SS0EFnvzXFH22Ww/vdS68irMaaqS3KONwPy
         Hjk4llgG/Q0GVdElDTlUlK5AfBdLgK2rA+d5eeHM4eI/Ie3FAS8NSod/6xm3PP9T/QtS
         Fy5Q==
X-Gm-Message-State: APjAAAX8X5HEIXp9vmTTS5xBsd0AU5R7zuVFVLnQM8MgzzlkZxBDEKFW
        CLeDzRA6pK+5AAEeWYQ1mE0=
X-Google-Smtp-Source: APXvYqwaVSh2wfqR7ZJl9zgO332rafYDXj6QzlZhom3wr8XM08rG9eVv6iOzeEuki1e+ISyRdsb1dQ==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr2175499wru.49.1564669025577;
        Thu, 01 Aug 2019 07:17:05 -0700 (PDT)
Received: from rric.localdomain (x4e365c6b.dyn.telefonica.de. [78.54.92.107])
        by smtp.gmail.com with ESMTPSA id p6sm78875566wrq.97.2019.08.01.07.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 07:17:04 -0700 (PDT)
Date:   Thu, 1 Aug 2019 16:17:01 +0200
From:   Robert Richter <rric@kernel.org>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     thor.thayer@linux.intel.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, morbidrsa@gmail.com, ralf@linux-mips.org,
        david.daney@cavium.com, andy.gross@linaro.org,
        david.brown@linaro.org, ckadabi@codeaurora.org,
        vnkgutta@codeaurora.org, jglauber@cavium.com,
        khuong@os.amperecomputing.com, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 1/1] edac: Add a counter parameter for
 edac_device_handle_ue/ce()
Message-ID: <20190801141701.bmcken464mrqwhdg@rric.localdomain>
References: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
 <20190801113548.7leooh57gihixen5@rric.localdomain>
 <7d6aac9e-20e5-3901-a423-d76ac917b251@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6aac9e-20e5-3901-a423-d76ac917b251@amazon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 01.08.19 15:29:03, Hawa, Hanna wrote:
> On 8/1/2019 2:35 PM, Robert Richter wrote:
> > On 15.07.19 13:53:07, Hanna Hawa wrote:
> > > Add a counter parameter in order to avoid losing errors count for edac
> > > device, the error count reports the number of errors reported by an edac
> > > device similar to the way MC_EDAC do.
> > > 
> > > Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> > > ---
> > >   drivers/edac/altera_edac.c      | 20 ++++++++++++--------
> > >   drivers/edac/amd8111_edac.c     |  6 +++---
> > >   drivers/edac/cpc925_edac.c      |  4 ++--
> > >   drivers/edac/edac_device.c      | 18 ++++++++++--------
> > >   drivers/edac/edac_device.h      |  8 ++++++--
> > >   drivers/edac/highbank_l2_edac.c |  4 ++--
> > >   drivers/edac/mpc85xx_edac.c     |  4 ++--
> > >   drivers/edac/mv64x60_edac.c     |  4 ++--
> > >   drivers/edac/octeon_edac-l2c.c  | 20 ++++++++++----------
> > >   drivers/edac/octeon_edac-pc.c   |  6 +++---
> > >   drivers/edac/qcom_edac.c        |  8 ++++----
> > >   drivers/edac/thunderx_edac.c    | 10 +++++-----
> > >   drivers/edac/xgene_edac.c       | 26 +++++++++++++-------------
> > >   13 files changed, 74 insertions(+), 64 deletions(-)
> > 
> > > diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
> > > index 1aaba74..cf1a1da 100644
> > > --- a/drivers/edac/edac_device.h
> > > +++ b/drivers/edac/edac_device.h
> > > @@ -290,23 +290,27 @@ extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
> > >    *	perform a common output and handling of an 'edac_dev' UE event
> > >    *
> > >    * @edac_dev: pointer to struct &edac_device_ctl_info
> > > + * @error_count: number of errors of the same type
> > >    * @inst_nr: number of the instance where the UE error happened
> > >    * @block_nr: number of the block where the UE error happened
> > >    * @msg: message to be printed
> > >    */
> > >   extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> > > -				int inst_nr, int block_nr, const char *msg);
> > > +				  u16 error_count, int inst_nr, int block_nr,
> > > +				  const char *msg);
> > >   /**
> > >    * edac_device_handle_ce():
> > >    *	perform a common output and handling of an 'edac_dev' CE event
> > >    *
> > >    * @edac_dev: pointer to struct &edac_device_ctl_info
> > > + * @error_count: number of errors of the same type
> > >    * @inst_nr: number of the instance where the CE error happened
> > >    * @block_nr: number of the block where the CE error happened
> > >    * @msg: message to be printed
> > >    */
> > >   extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> > 
> > How about renaming this to __edac_device_handle_ce() and then have 2
> > macros for:
> > 
> >   * edac_device_handle_ce() to keep old i/f.
> > 
> >   * edac_device_handle_ce_count(), with count parameter added.
> > 
> > Same for uncorrectable errors.
> > 
> > Code of other driver can be kept as it is then.
> 
> Don't you think it'll be confused to have different APIs between EDAC_MC and
> EDAC_DEVICE?
> (in MC the count passed as part of edac_mc_handle_error())

I don't think edac_mc_handle_error() with 11 function arguments is a
good reference for somethin we want to adopt. For the majority of
drivers you just introduce another useless argument with the following
pattern:

	edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev_name);

IMO, the api should be improved when touching it.

-Robert
