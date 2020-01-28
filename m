Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3314BD83
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jan 2020 17:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1QQb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jan 2020 11:16:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgA1QQb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Jan 2020 11:16:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SGDVk1014825;
        Tue, 28 Jan 2020 16:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=qy22FaHfum9y12gC/r49okFpviWfxvUrEe5zPiGQYQI=;
 b=Vg+EkxjuU4sJv1Dre6mWsetm78pjlhTpv6+JULUxOraq0/AUP/xB+PMzTVkaG5mGSh0h
 5xfa2Shcvi6mWYlbsHTHBsVZvp4bdxnDJOUUkDavG6UikSirDcKGYsKUWSueGSksau4J
 oRWB6lTmVnXqa0M2cOuceA+AQO+ihTctumAY5IlGnhVic5olqzbCsRY3ot1UvRyi0Ikr
 16RplOaZIXi5BQs12EFRNwEBAsdKuQiotuK/MQzHMMh36pGdUuM/55O+SUnOM5qZ7kwi
 gyB5FlatEHYDnJ7TqH/QzMVOjV+xCEKYf3BljgHijaThYZoKn4p/vWZTggel/VqwserC tQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xrear78ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 16:16:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SGEQcd124833;
        Tue, 28 Jan 2020 16:16:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xtg7v6v81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 16:16:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00SGG7j6005880;
        Tue, 28 Jan 2020 16:16:07 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 08:16:06 -0800
Date:   Tue, 28 Jan 2020 19:15:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saar Amar <Saar.Amar@microsoft.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: [EXTERNAL] [PATCH] x86/MCE/AMD: Fix use after free in error
 handling
Message-ID: <20200128161556.GB1754@kadam>
References: <20190813100752.GM1935@kadam>
 <20200128140846.phctkvx5btiexvbx@kili.mountain>
 <AM5PR83MB01951D715568E2BFD67C51AAF10A0@AM5PR83MB0195.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR83MB01951D715568E2BFD67C51AAF10A0@AM5PR83MB0195.EURPRD83.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=735
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=799 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280126
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 28, 2020 at 03:59:08PM +0000, Saar Amar wrote:
> Actually, if we are at it - Dan, given the fact there is an actual use
> (a dereference) for that pointer after the free, shouldn't we assign a
> CVE for it?
> 

We don't give CVEs, you'd have to contact someone else.

I don't think this has a security impact because you already have to
be root to trigger it.

regards,
dan carpenter

