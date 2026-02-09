Return-Path: <linux-edac+bounces-5703-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GioE9RMimlnJQAAu9opvQ
	(envelope-from <linux-edac+bounces-5703-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 22:08:36 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5B114B24
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C289300B9CF
	for <lists+linux-edac@lfdr.de>; Mon,  9 Feb 2026 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010EC30BF70;
	Mon,  9 Feb 2026 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z7FxUEBB"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4EC8F0;
	Mon,  9 Feb 2026 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770671313; cv=fail; b=nEEEBSXgzD5Ufw9D+4qp8BJdEdYEJXwDO8QFTEyAdC7Zpt6cKNVSM/U/7xTSIukkWnSRew1JiasC9SpAl0B4LwFu2qOWVL4hBxDN3s0ugvQ7O1VuBbtKUVVps9PImBBci5T59NgmKE1vCa35DlSm7zN1zjTLMkwvQDs8/NwkfsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770671313; c=relaxed/simple;
	bh=9xzBluPxdGXYJN9yEL6fuFx8jKHeWYPzmjNu2Q1Jd0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UtLUsBGA0Am+P7tYeco//wj/tFF/MG5MyuAA1pp0P09wH9MbYkzZUcJA1V+sFbJAlZ+fwyDWKH+UFxBFaWbqFRpM/8UYUZFPld8rMMBbNDOLnnJBe2gRDeqdc8yOTZcYGIyzA4jstFzgJdQ9E2l3qHJEXBOOlAd9e2EH4LIm6Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z7FxUEBB; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI/MBNefxDeudMfYrMS6S0YpfOmCytMQKZzLuHmVpQLZo6POzxJAsLCnDNamiZq77/tCU4HtwziLGEyv2/Jpp8EXGAMPLqG4ODJGzaShbDRS7mSX0uCR3C9yqTH0e6750ehcrBGkHmunQaV8kL1ZgO92tAMYW3geb0lPsqMQwV5qAjEHDxuVsTl/y8ZeNEX+sV0wg7iZOHmTyptrJQpdEJyGcTiKm6p+XM/JWdsPR8C1zU5OBWrRFKa1+aOQunQoBQRqRT9MtIJcjYqQrSox/0kKCEYsmrHgRD1StxfzJq6ibPVxQV5o1g3PWLoiMWPU53ctPiTLSbZaUGdL+/8SLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9bbRQth1saQhVBi9iMM1lwMIYZNnDJj9CUqVrBbtq8=;
 b=qGAW8QYO46eQAtuNU680wWf+q4bDHFg+utphbkQ2YaxCrSN0pFs9qVUfrkLA5i1uqxbw1wEZwPzoN/VRGtZ1irwunyIfYd6u14TjFTKnOQzBYjnWiaZljett9YXixdHDCL7vvV/jFQ8aP9H2FV02QrBuS0vq6ZPwfkEK80Hw0am5qGL+/yq1FQfxNvasZMpZrlEJ6ptWD4B2f8ahbkSjundp6a2eiShyxyE6nz/Cso8HP3a3vXF6Ml9io8MhTIePw0+8KOFXNAhmivjTbqf1ddx+c+eVaMNcZn8vIU4Q+qXtj4O987LQzYMKZUBhdhUJ3oC7R4uKGI5Nz7V9v1d2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9bbRQth1saQhVBi9iMM1lwMIYZNnDJj9CUqVrBbtq8=;
 b=Z7FxUEBBCxxCQsjXYJUr1kWDzL0QIL1XPAAG0vb7Kl+pCqrjBnAJOyk8NWhd/zCcnMzS5FhGdPj84w1Xe4/A+ufB/qle5nN26MU72grIJdG7DnwvlqD73DWe3NmIm1q13PG3vRxbuLjmRw1DfPtuPtThho4sJDk4jLYPknWj6nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Mon, 9 Feb 2026 21:08:28 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 21:08:28 +0000
Date: Mon, 9 Feb 2026 16:08:19 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: William Roche <william.roche@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>, bp@alien8.de,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	"Allen, John" <John.Allen@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] AMD VM crashing on deferred memory error injection
Message-ID: <20260209210819.GA445331@yaz-khff2.amd.com>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a89278-b0b2-4c09-0b94-08de681f5ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrpc+zo8pqjO5yUK6suh/M3e1ilFTeUxxo1Ih7TRC/Yi3XUdmVgjPnVG0QzN?=
 =?us-ascii?Q?TNx23+9Lx9zoow7oAXw7+HxWhJJ3RdqSY4dYZv5IIpJ4nkOLmLjGBNDOUvRe?=
 =?us-ascii?Q?y/xzLM6N3SmMkAf0GP1z2f3XWwa77uHpB2nUwX+WICdvMNuzfjKLtnwQdsxe?=
 =?us-ascii?Q?ryWv7x/cy1H/bdQXwKH5D9E+9dJAWAQg7Vtmnlx9waXbmDeRKXVrRYukagBM?=
 =?us-ascii?Q?iFEOYLqOuUAfKYgugq+Ghz13xKXeYeRHriEQllCv+t+Cbt14eKmvLjUpfZik?=
 =?us-ascii?Q?n8MeNk2OwafgD7WD8i86KxyilY7hn1SGuLjTx3VT0bY0sulYY4Z6KY7f+eA4?=
 =?us-ascii?Q?xVJO8piNzqWYH+U5rvjj/VqR9AVA5+5RZYZLzsY18cGrNgNV08rxbMSMCyy+?=
 =?us-ascii?Q?DQNxv7N5yx3o1n6jKgSPErQqNjKLTMymyTuBCr6iGBNUFzz+nfKxkaIcxnQF?=
 =?us-ascii?Q?Ik+TZwo4l9QLSWmT39jxSORu7sTad3ZVzcCYhz2x7M/wzemijm7tGML0wv31?=
 =?us-ascii?Q?9lLjrL8/f1fmrbyvx+Dn32K+VEDmpYTFR31yE0HaFAQVTXaoYTZxpqQabdQ9?=
 =?us-ascii?Q?FJWfyg471k1jKMsDclBWXRVBWOe+mM4lMEwxOi8T/O9JDVKW6aIdo9xw2vtl?=
 =?us-ascii?Q?ZzmdXuoURE/WjXdDoiagU7mIy1oAhR0JPRTu28WQX22g54itG01hdvEdfupg?=
 =?us-ascii?Q?bnrmDgaDDP3T34DbEYO6zKUq7dnb4uyBRhnxTrmM7Pu3jqjdM/IUwXPxERTN?=
 =?us-ascii?Q?tUF8yYTe15GeVxiWSWiWNB4LqsKEGo4Yfsea0tvUOfmD1UOFsswwkdOF+1/C?=
 =?us-ascii?Q?BfbIMQdWX0ESw1H4LjiZZmyEOeuAke86+sCVm78ACvCh76fetbXrTeVsiiux?=
 =?us-ascii?Q?xRmS8dBNUcrfKZG4RYgWmCPnMEbfQBKfdaThnFaDA/M8YRLhi6EaUBKXWUlw?=
 =?us-ascii?Q?2ErJf2Vj7kwM94VI6e9SZgQaoBxiDS6wHGn5af1VbdWdUVFsipbB/W27o1cK?=
 =?us-ascii?Q?QIz0YpCFSjMhHgHnldC4FwCTYEijtXN4w6QRBL2XcRlc0CKWZzm0CKoRt32H?=
 =?us-ascii?Q?REZU4gSlmd6zwE4+K2TNNgUqEnNgPNJxLt78hol74Y0BayR5CzdpcUi2I4fk?=
 =?us-ascii?Q?oPj1/HOkyb9Q5q14ssimfz5yTvIpupLTNJmpJfRXyFTa+VzA/EKA7XDo7PrY?=
 =?us-ascii?Q?G2B3yGt37pCBh9lxkKooPy2Ttr7Fte9PSPCyZn16ZU7whJ29VRu8/Tnp0GpE?=
 =?us-ascii?Q?u9z58bChvLcXSIrQCBb2lIGMuapAcpY2ByMlqHjz407Kh26FEzuyH+M9ao3+?=
 =?us-ascii?Q?ttTVc6snuR033ZdmoGFpJoUZXeIlB6RZ9/amT0wcWFXYEFQ0RMLX/v+ZNeKj?=
 =?us-ascii?Q?rseMjGo7uDa5xXLTwzSsND9JGektn2Mv8t9UUnyeaOHwKpLrr3rlW0u97nrw?=
 =?us-ascii?Q?F8yQ9c6X0g/tW9+sU2Dfr2SCL2GjFdrWJFYYKnLKtAOWYnLs4hY4zn/s6QWS?=
 =?us-ascii?Q?25vF2nP/T5RckZyk6nYSnOPMjdBiz4fzKU7mWmFsRVzgRWNUzBTbHOAxtnoS?=
 =?us-ascii?Q?iInoBRkNXDTaRaS+KYo8t50ZBSg3oHufJDM0bR+k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgQVHG5LoLtlY9CNc/uTSgQhiOaofdKnbPt4v0DX0RPpR9ZnKwPFOd7J9VVD?=
 =?us-ascii?Q?v9IEiklSak8+L3z9ZsxjyMvtafWMafb1bY8KexfST2i71zVChncwa7QE36sK?=
 =?us-ascii?Q?2ZiUqALhwFbnVtvNX4H1OrSiXwU+HHow7nxQXqtuHHwuSb6iFJSU3kik8/O8?=
 =?us-ascii?Q?kAtwBAoSlyFuFYMCQUVMB2XFXuiTDYSXRauqk+0ant6hJ8LfXZtLsK8eRyYA?=
 =?us-ascii?Q?B1tLmYHDIvd9djFa8wroIfT251p3orMCKfGWUypvoIMpq/5pK5eF4odelmkr?=
 =?us-ascii?Q?KU4LPcMGjY0iaNtKJ7CTHratAg5I1OuBYIIl/Hm98TQLd9MyeQYo5MGid82g?=
 =?us-ascii?Q?easmM91X7FTuzaN47awYRhG1l647IA2llh/tXWBcIMy2HgxXpj+4STUv/EWA?=
 =?us-ascii?Q?k7+zTv3epbPwZhXBFGmN+45XrzE5ddhHT1HJPKYf5vVsxNXvmRZmPdy2nQzX?=
 =?us-ascii?Q?BwkJjXzzqiT7ot/hRPJcWpsZDreLIHwOT9qM8JDQkC1wRP6Yugfk1ZylwUYE?=
 =?us-ascii?Q?UhUQkUWB89YpdBpz45Z4dXXq1uiZAImfSxwK/EwOjHZCGIFnHmXJf0UPPfTr?=
 =?us-ascii?Q?CWb2PpvB6VDb9zCX/BjyUKidHxwG3KfwbcixnY3LL7P5GW8WgMvzkqOE81mk?=
 =?us-ascii?Q?BwFtCGNZjCbu7n4dIbEq2QQoX/bx8HQQmmMyxzoxrSQcX3dZS6RwPcngwinB?=
 =?us-ascii?Q?rI5mgLXx4IH/GMKuxKxi3vzaiT4Z8kFADZqia0vpceseUArIcS6eyZs+dNvR?=
 =?us-ascii?Q?CBwwz0HhQ84v/Z0Lc7vHmtgyDb7gNujQPwWRYUZLnVymOU7bHPPvLYAK82QQ?=
 =?us-ascii?Q?Hf5UP8lSsTTjehZQNlgjr4p76P6gFBcHZoomV0BO4aOX97Q58X0OU2Aqdwh7?=
 =?us-ascii?Q?KOxEz7fhUTZ0Yp229WFClXAG7UkaFyIvBE5er9Yb1jn8TZrVT2GJSucYVTbt?=
 =?us-ascii?Q?BCm7WFwUM7cWMAty1U/Qlll9qsHe+ymThZfkJdv27gswT7NnVMKTYxVBqpct?=
 =?us-ascii?Q?NV5WCn4IcPMFaaNXca/gYJa0hvExqTtZjtEw+f/iAWUJV0qdG2PryInge8Ke?=
 =?us-ascii?Q?zEmZb+sJ4oX2vAmuL04uIHyK/vijat9FTBGsn51Hzs4LBDUCUGmIUOMZxkH+?=
 =?us-ascii?Q?b+n9aQg6j4ll4Kv5Y8dzdU0rQhr5VfSuWISaZ1lshj7/ZKyT87KS4iLYMtRb?=
 =?us-ascii?Q?NI9OcL3aRVE7Tjal42XuT0yPFEWAlXPkB7qbWM//OhBRT11kbeWd/K7lt9i2?=
 =?us-ascii?Q?ADLC3KfihufWBrpuFnyI3qA/1OKqEUdCy0138pv3t/9BGXd5B7i62EBNWQ36?=
 =?us-ascii?Q?63Sh75+UqsrCYKatDPQrbdJGSYUkoDUUCXDrDsUum4jROQMrdDRZ5cpXPDcg?=
 =?us-ascii?Q?l4/7qEeSu0HnqzSopUgFIYCLsx5TChFCRyJS4U7MrovwIC/9Rc50oJYbkEg5?=
 =?us-ascii?Q?3K/aCXviDbVWscUULtZ5U3zA31Jb1USYZSsTXGCmQ6OFPHpWhS2e94VOdnOP?=
 =?us-ascii?Q?9Ykp1W0whFLaQJTkePyvl0v3CFRcA3DTQ23w0R9R9ox10I0i15jqg3/S8PLV?=
 =?us-ascii?Q?aDnmmtYUnAzwpqP9Afyw8KMteBfABoT5IiyS0e7dKFB7mBawx+0MalNxVVEn?=
 =?us-ascii?Q?CDi7rK6Rrr+tjFdnTkmKPweBcCcqy9CsR8A5qzVGmEHf5c/ifv4anybwyZ1M?=
 =?us-ascii?Q?/mdAwCGi7bKlWeOwYfMp7X6zk/R3G8Ucei4QKDAo/NlV/GEMOGbzf1mgo1T3?=
 =?us-ascii?Q?M3Q4cuQM/w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a89278-b0b2-4c09-0b94-08de681f5ecf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 21:08:27.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rDCafQN8ESEuUBnaidOBm012T1xUmkiQfmLn+oIGKcOvbnEvvkdTK7yLMjfxdfDTwXUunHmAtlPJD6ekOBgyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5703-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim]
X-Rspamd-Queue-Id: ACE5B114B24
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 05:36:32PM +0100, William Roche wrote:
> Hello,
> 
> I'd like to bring to your attention a consequence of the integration of
> this set of commits early into the 6.19 kernel:
> 
>   2025-11-04 14:55 [PATCH v8 0/8] AMD MCA interrupts rework
> https://lore.kernel.org/all/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com/
> 
> Yazen Ghannam (7):
>       x86/mce: Unify AMD THR handler with MCA Polling
>       x86/mce: Unify AMD DFR handler with MCA Polling
>       x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
>       x86/mce/amd: Support SMCA Corrected Error Interrupt
>       x86/mce/amd: Remove redundant reset_block()
>       x86/mce/amd: Define threshold restart function for banks
>       x86/mce: Save and use APEI corrected threshold limit
> 
> 
> An AMD Qemu VM running this kernel is no longer able to deal with the
> injection of a deferred memory error, and crashes with:
> 
> [  333.420854] mce: MSR access error: WRMSR to 0xc0002098 (tried to write
> 0x0000000000000000) at rIP: 0xffffffff8229894d (mce_wrmsrq+0x1d/0x60)
> [  333.428105] Call Trace:
> 
> [  333.429566]  <IRQ>
> 
> [  333.430745]  amd_clear_bank+0x6e/0x70
> 
> [  333.432828]  machine_check_poll+0x228/0x2e0
> 
> [  333.435068]  ? __pfx_mce_timer_fn+0x10/0x10
> 
> [  333.437241]  mce_timer_fn+0xb1/0x130
> 
> [  333.438966]  ? __pfx_mce_timer_fn+0x10/0x10
> 
> [  333.441380]  call_timer_fn+0x26/0x120
> 
> [  333.443518]  __run_timers+0x202/0x290
> 
> [  333.445763]  run_timer_softirq+0x49/0x100
> 
> [  333.447908]  handle_softirqs+0xeb/0x2c0
> 
> [  333.449863]  __irq_exit_rcu+0xda/0x100
> 
> [  333.452065]  sysvec_apic_timer_interrupt+0x71/0x90
> 
> [  333.454846]  </IRQ>
> 
> [  333.456192]  <TASK>
> 
> [  333.457520]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  333.460355] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [  333.463203] Code: 20 d0 e9 5f 99 e6 fe 0f 1f 40 00 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 33 ee 18 00 fb f4 <e9>
> 37 990
> [  333.472816] RSP: 0018:ffffffff83403e78 EFLAGS: 00000246
> [  333.475848] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [  333.479481] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [  333.483492] RBP: ffffffff83412980 R08: 0000000000000000 R09:
> 0000000000000000
> [  333.487503] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000
> [  333.491482] R13: 0000000000000000 R14: 0000000000000000 R15:
> 00000000000947d0
> [  333.495258]  default_idle+0x9/0x30
> [  333.497283]  default_idle_call+0x28/0x100
> [  333.499641]  cpuidle_idle_call+0x12e/0x180
> [  333.502087]  do_idle+0x77/0xb0
> [  333.503914]  cpu_startup_entry+0x29/0x30
> [  333.506337]  rest_init+0xcc/0xd0
> [  333.508296]  start_kernel+0x4df/0x4e0
> [  333.510491]  x86_64_start_reservations+0x32/0x40
> [  333.513101]  x86_64_start_kernel+0xce/0xd0
> [  333.515433]  common_startup_64+0x13e/0x141
> [  333.517920]  </TASK>
> [  333.519468] Kernel panic - not syncing: MCA architectural violation!
> 
> 
> The problem appeared with the addition of clearing MCA_DESTAT for all
> deferred errors in the amd_clear_bank() function by this kernel commit:
> 
>     7cb735d7c0cb  x86/mce: Unify AMD DFR handler with MCA Polling
> 
> +       /* Clear MCA_DESTAT for all deferred errors even those logged in
> MCA_STATUS. */
> +       if (m->status & MCI_STATUS_DEFERRED)
> +               mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
> 
> 
> Where a Qemu AMD implementation of MCE injection for deferred errors
> relies on machine_check_poll() picking up these errors.
> As indicated in Qemu change:
>     4b77512b2782  i386: Fix MCE support for AMD hosts
> https://lore.kernel.org/qemu-devel/20240603193622.47156-2-john.allen@amd.com/
> 
> 
> When a Qemu process receives the SIGBUS information from the host, it
> generates a virtual MCE to be dealt by the VM kernel machine_check_poll().
> But clearing MCA_DESTAT doesn't seem to be allowed and triggers an
> exception. Which looks like a kernel & AMD SMCA contract mismatch (?)
> 
> So should we consider that the Qemu platform has to allow the change or
> is the kernel missing guards around clearing this MCA bank after
> injected UEs on this platform ?
> 
> 
> FYI, to reproduce the problem:
> . I used a QEMU Standard PC q35:
> 
> qemu-system-x86_64 --version
> QEMU emulator version 10.2.50 (v10.2.0-1085-gcd5a79dc98)
> Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers
> 
> qemu-system-x86_64 -smp 4 -m 20G -enable-kvm -cpu host -usb \
> 	-device usb-tablet -serial mon:stdio -M q35 \
> 	-nic user,model=e1000,hostfwd=tcp::60022-:22 -nographic \
> 	-drive file=disk.qcow2,cache=none
> 
> . Inject an error into this VM running a 6.19.0-rc1 or more recent kernel.
> From the host:
> # modprobe hwpoison-inject
> # echo <pfn> > /sys/kernel/debug/hwpoison/corrupt-pfn
> 
> Wait 5 minutes until the deferred error is handled by the VM kernel, and
> the VM than crashes with the above stack trace...
> 
> 
> . But removing the reset of MCA_DESTAT in the kernel amd_clear_bank()
> function or adding this simple test makes the system work again as
> before:
> 
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index d9f9ee7db5c8..86b3070fbb40 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -860,7 +860,7 @@ void amd_clear_bank(struct mce *m)
>         amd_reset_thr_limit(m->bank);
> 
>         /* Clear MCA_DESTAT for all deferred errors even those logged in
> MCA_STATUS. */
> -       if (m->status & MCI_STATUS_DEFERRED)
> +       if (m->status & MCI_STATUS_DEFERRED && !(m->status &
> MCI_STATUS_POISON))
>                 mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
> 
>         /* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
> 
> 
> 
> According to me, this small kernel fix relies too much on a Qemu AMD
> specific implementation detail.
> 
> Would you have a more appropriate fix to suggest please ?
> 
> Thanks in advance for your feedback.
> William.

Thanks William for the report and details.

Clearing "STATUS" registers is a normal part of MCA handling.

We seem to allow clearing the regular "MCi_STATUS" register. I assume
this gets trapped/ignored by the hypervisor.

I expect we need to do the same behavior for the "MCA_DESTAT" register.

I'll do some research here, but please do share any pointers you may
have.

Thanks,
Yazen

