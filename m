Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02D98D627
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2019 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfHNObs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Aug 2019 10:31:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50312 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNObs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Aug 2019 10:31:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EEJ2uL099163;
        Wed, 14 Aug 2019 14:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=4orpuPEli+qrXHM6zo8rys0+YwIGeeH6zxS6a5hqY3U=;
 b=Z90ytQvdaH9DkKNMflPcUiztIHwRt8WvxvgYS4ibFOpzymHhgduBnapTVEIofKaLpVeX
 LyQs2XhhpVUUQ60hotA/r+yUCfWN5Pw1kTM+KR9b9Ww1DFiwNFshC4yIhEjsdjWjJiKz
 xZ00PWN7Fnf0pa5EUyJ2gXbvmY5iIRaIWJJaKJXs4bVBki898zRd/R4XREGNX7QuAJnr
 gF+8TydYQ78dwpbr0Wm4xl2oBFWq/uI0wylUa7MSURcr7QGoPIK+U2V4/l4yENcUD9uk
 f+Afqi4xoyPr7Z/1DHQbHCDR8LoHBhz7kzG02OPymscfxhqhTGyH3h9YZGrCze4CWSOK Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u9pjqn2v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 14:31:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EEHeqh069373;
        Wed, 14 Aug 2019 14:31:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ubwrhaee0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 14:31:44 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7EEVg8m027774;
        Wed, 14 Aug 2019 14:31:42 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 07:31:41 -0700
Date:   Wed, 14 Aug 2019 17:31:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     yash.shah@sifive.com
Cc:     linux-edac@vger.kernel.org
Subject: [bug report] EDAC/sifive: Add EDAC platform driver for SiFive SoCs
Message-ID: <20190814143136.GA3226@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=925
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=975 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140149
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Yash Shah,

The patch 91abaeaaff35: "EDAC/sifive: Add EDAC platform driver for
SiFive SoCs" from May 6, 2019, leads to the following static checker
warning:

	drivers/edac/sifive_edac.c:60 ecc_register()
	warn: 'p->dci' can also be NULL

drivers/edac/sifive_edac.c
    43  static int ecc_register(struct platform_device *pdev)
    44  {
    45          struct sifive_edac_priv *p;
    46  
    47          p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
    48          if (!p)
    49                  return -ENOMEM;
    50  
    51          p->notifier.notifier_call = ecc_err_event;
    52          platform_set_drvdata(pdev, p);
    53  
    54          p->dci = edac_device_alloc_ctl_info(0, "sifive_ecc", 1, "sifive_ecc",
    55                                              1, 1, NULL, 0,
    56                                              edac_device_alloc_index());
    57          if (IS_ERR(p->dci))
                    ^^^^^^^^^^^^^^
The edac_device_alloc_ctl_info() function never returns error pointers,
it returns NULL.

    58                  return PTR_ERR(p->dci);
    59  
    60          p->dci->dev = &pdev->dev;
    61          p->dci->mod_name = "Sifive ECC Manager";
    62          p->dci->ctl_name = dev_name(&pdev->dev);
    63          p->dci->dev_name = dev_name(&pdev->dev);
    64  

regards,
dan carpenter
