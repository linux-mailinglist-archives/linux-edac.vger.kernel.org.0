Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2354EEDF
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2019 20:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfFUSm4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Jun 2019 14:42:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFUSmz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 21 Jun 2019 14:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XwdYT7FV2KSNzhAMqgZTH7sujg01Ei6koIDV1vSkSF0=; b=UGadLKT04Ni4bwjMLFz7GCOaF
        qcK1CRuryHTlCYtS2ymgHmVXyRES/0d7Exb9pIiGj060+QaBrH4smbkZqkyL6LnnYN62Y6gnQv5XQ
        +mn1puUVMiftAOx5VXo3/INjIF8zuQkMcFuLPNeMe7ZKvJhAFLM2KUK+EvOMxZ0PPAR8eJ6j4uRsD
        mdtZ/TlMDnP/Wcbx+Tctyj8ZKJFbTaoCgZOHEYcEQZ2m79wV55o97DNEazdpiXp1xZT3Roft6Q0Sf
        DS42MDsRAqaB9osR0ULWAAWgI9RpybcWvYALvqPStiBme0aiHHJZmaJ9CKRVMEd2PtGJ7poa5X2M8
        HGyQg+UFg==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heOUx-0002WB-7I; Fri, 21 Jun 2019 18:42:55 +0000
Date:   Fri, 21 Jun 2019 15:42:52 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH 0/6] rasdaemon:add logging of HiSilicon HIP08
 non-standard H/W errors and changes in the error decoding code
Message-ID: <20190621154252.45afd172@coco.lan>
In-Reply-To: <20190617142852.12140-1-shiju.jose@huawei.com>
References: <Shiju Jose>
        <20190617142852.12140-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Mon, 17 Jun 2019 15:28:46 +0100
Shiju Jose <shiju.jose@huawei.com> escreveu:

> This patch set add few changes in the non-standard error decoding code and
> logging for the HiSilicon HIP08 non-standard H/W errors.
> 
> Shiju Jose (6):
>   rasdaemon:print non-standard error data if not decoded
>   rasdaemon: rearrange HiSilicon HIP07 decoding function table
>   rasdaemon: update iteration logic for the non-standard error decoding
>     functions
>   rasdaemon:add logging HiSilicon HIP08 H/W errors reported in the OEM
>     format1
>   rasdaemon:add logging HiSilicon HIP08 H/W errors reported in the OEM
>     format2
>   rasdaemon:add logging HiSilicon HIP08 PCIe local errors
> 
>  Makefile.am                |   2 +-
>  non-standard-hisi_hip07.c  |  36 +-
>  non-standard-hisi_hip08.c  | 855 +++++++++++++++++++++++++++++++++++++++++++++
>  ras-non-standard-handler.c |  36 +-
>  ras-non-standard-handler.h |   8 +-
>  ras-record.c               |  30 +-
>  ras-record.h               |  13 +
>  7 files changed, 932 insertions(+), 48 deletions(-)
>  create mode 100644 non-standard-hisi_hip08.c
> 

Applied, thanks!


Thanks,
Mauro
