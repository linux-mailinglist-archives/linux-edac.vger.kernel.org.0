Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F521EC9D8
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jun 2020 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgFCG52 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Jun 2020 02:57:28 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:53242 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgFCG52 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 Jun 2020 02:57:28 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0536nrLj007448;
        Tue, 2 Jun 2020 23:57:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=wC95efS1auVg0O0kAyMpJqFWQfZI2Tt6llUaChJW/HM=;
 b=ZK4FfcH4a3HjhQZ+LLdGLaJfVD3+Cfm3cLWW3FJfpqXaCjh4p5tPVdOqSKAdHmMtOfIu
 fAsVytgmO5ZDw8ZCBNrYaprXxvs0KosiwMKb6RoL27ZYXz7DOvmPteuVsk5LdfSb5DLX
 k6hinfoqbUd+kCjaxWgXCAGPu9se2oa0Nsi0o6aUCmNFVvRTde28UnlUyTIqnG7CbQWw
 Z1PVQATF9Yrim4Y71wdTJsNhHdMsxOVtYyWTiR9eq6ggI1TPO2jMJAFG30pUXU+sjguT
 5kRArTl9DAqgS+4O5XwJKDYIQ8M6xm7JK4cBdNieWrj4k6ta5z/qJ876JnCS2lt3mDSm Lg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 31bmupxh96-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 23:57:11 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Jun
 2020 23:57:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Jun 2020 23:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3E1R7IjUZdwUui/QDeUfGa1EWMWyGtxDbGQt07/FLZoO/cIk9L5IBz24CHptQiDkWxYhFhG2CZgWLHwNvaayjup/WT4ehOcFFIMEjWEqtbgzDlC1JBfcF6xvIBlCY8alZxB8HnKjFCJOXVNzDx9Qyo7eaiTugX94/SyFEdPDroBCd8FfJ5VeaW6hUyNtNIgPfszIeL7Af/vEKpgdy2BiheWw1w5lIoLl2dpUYR+YMjd+kMWunvrqyRNsRBIe4l9kCb9+63TxCn9MPtu67+/NbWU+yzgCIxrGXFcmsJD/gUH3VYudKHOkV3l9A9qTFqhtMg4w4H99FLpqPA4mXyUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC95efS1auVg0O0kAyMpJqFWQfZI2Tt6llUaChJW/HM=;
 b=bqUZY7YwVPavnGjYEHTqnJ22F159b/jBtEJSLTgEJSC8G641QI+4K0y1GzV7CHSQFbWHTQSlk16fsGeaBpRY+zwEj5/Vxpr7UZ/RMj32KkuQFmjrWVm/vPHH0hbEylZEEaJ0elheW6m9cMFc7JEgijnLxSScyDHqhIxlUgQbyOBN1F4msQpUl9Z35uPiKu7ImplvEPPW9a61ce5MctqDW+SF74m9LiRpvzXtetZNKaDEDGK5cvv9HZxmN0RZqt82w/PJaaxd3OPHIDQ8cyN9fS7QPVUdcB7hb28nP5NrMAN1ua2EgvoZKEhce/j+wpG95FStpuVVdyq8MjVErD2Szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC95efS1auVg0O0kAyMpJqFWQfZI2Tt6llUaChJW/HM=;
 b=L+ZQj3LOTQOT8awOxOA6+8JuZBVObMw3fPJZT+ktH7ehT2vd8zs6aLKC6V9rnENyeCJRo0qjLfG47mIz7bMm09Yic2EBIGAV9yI/ZW53P/uv1kyuTFodz5mC8ZxqwoF28cmvKERk3MUGzPfxXHqra74GptoGdArBAQhhp7DndKY=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2807.namprd18.prod.outlook.com (2603:10b6:a03:111::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Wed, 3 Jun
 2020 06:57:08 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 06:57:08 +0000
Date:   Wed, 3 Jun 2020 08:56:58 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] EDAC/ghes: Setup DIMM label from DMI and use it in
 error reports
Message-ID: <20200603065657.zrxer5jtgryqlznt@rric.localdomain>
References: <20200528101307.23245-1-rrichter@marvell.com>
 <20200602154843.GD11634@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602154843.GD11634@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0343.eurprd05.prod.outlook.com
 (2603:10a6:7:92::38) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0343.eurprd05.prod.outlook.com (2603:10a6:7:92::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 06:57:06 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d263da-3389-4cd0-42c6-08d8078b54ea
X-MS-TrafficTypeDiagnostic: BYAPR18MB2807:
X-Microsoft-Antispam-PRVS: <BYAPR18MB28071DC95ACBED6828BC89A6D9880@BYAPR18MB2807.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YukT8xA7Vu23dTq1HM1cs/pHNvu/oQbf/SceYZyq4vOqeikTHavPT24MLLpEZemdnp9M8k2X7NWaPsB9j6Q+9emHkPHP+hscHRrmMk/JDOXvZwjqj548LYGysJA5wVw636H+M7HuL9BSwjPotYatXtCYa3Z6bCec1uh5/3ZHc05aksqHsrlpFBWa/Yi6mccjrgHoo0xmB9wRpP3zhpt81Yh5jOQx67N2y9rPmbWQIKoM+fEDVISGD/n2xyVs/pGzD2SzWsHy+SSgWoVqI214Siwd/1ajc4HEzFaKkAhhj2LBYVik7zfrK2E6mT2czA7OdnAYHtaVusKfXSt+nCJhIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39850400004)(136003)(376002)(366004)(396003)(5660300002)(1076003)(6666004)(6916009)(4744005)(4326008)(478600001)(956004)(2906002)(83380400001)(8936002)(8676002)(54906003)(16526019)(53546011)(6506007)(55016002)(52116002)(7696005)(86362001)(9686003)(66946007)(66476007)(66556008)(316002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W7CtzK3ygJTeTVkYKjwqxBIN0DbyOp20rtEHqwUC2AjwHO+uGoh0jIUtRPGkPXMsiqnQ1zSkbtIkVbzvjB9Ola2iGGoCpn/kwynulUQuXOVjvVjqSqv5Gz212UL9KvCJbc6HkjXZmO3N08xx2AcbZvy6MHjm/w1YPa6xDwFy/G9mHrGx81DE6TEVQVR8vLxGYuwwoVmDRCbSH52v/6ia0ChsbmPUxBQ65OpZARD1SGSkpXvvdlcZQcpwV79Q9GmJab6uuf2o8/zlJAldWJAGDA7Nrmo2eB72xSV0Y5zHXPMgXS5lTqs0lmIQy4hCNguZLvWOlSW2c6P5DXV51Zh1Lnc3BhoMVZDwdL9KOq0kxpAsxUeZXp2jCs63U5hGlv8N0gikr3tr5baUOFjah43JIJpMGD9VtgO9iEnSmHB7o1URz51WtwUsmiw/KmoKrNmVFKc7b6uUdItp7P0k8/NYe1cP0X4HK5JI94o89N1HuNY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d263da-3389-4cd0-42c6-08d8078b54ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 06:57:08.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WcG/7yDAvBqD9wf156BsnOA4C5cUJToRfoaG8fZCe3D6VyyU2c6Jw8jfcmURTacsjQQ5b5eXGbi6yTAS8LLfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2807
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_06:2020-06-02,2020-06-03 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.06.20 17:48:43, Borislav Petkov wrote:
> On Thu, May 28, 2020 at 12:13:06PM +0200, Robert Richter wrote:

> > v4:
> > 
> >  * dimm->label: Only update dimm->label in if bank/device is found in
> >    the SMBIOS table, this keeps current behavior for machines that do
> >    not provide this information.
> > 
> >  * e->location: Keep current behavior how e->location is written.
> > 
> >  * e->label: Use dimm->label if a DIMM was found by its handle and
> >    "unknown memory" otherwise. This aligns with the edac_mc
> >    implementation.
> > 
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/ghes_edac.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> Yap, looks good. I'll queue it after the merge window.

Great, thanks.

-Robert
